var liveInfo_manage_tool = null; 
$(function () { 
	initLiveInfoManageTool(); //建立LiveInfo管理对象
	liveInfo_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#liveInfo_manage").datagrid({
		url : 'LiveInfo/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "liveInfoId",
		sortOrder : "desc",
		toolbar : "#liveInfo_manage_tool",
		columns : [[
			{
				field : "liveInfoId",
				title : "记录编号",
				width : 70,
			},
			{
				field : "studentObj",
				title : "学生",
				width : 140,
			},
			{
				field : "roomObj",
				title : "所在房间",
				width : 140,
			},
			{
				field : "liveDate",
				title : "入住日期",
				width : 140,
			},
		]],
	});

	$("#liveInfoEditDiv").dialog({
		title : "修改管理",
		top: "50px",
		width : 700,
		height : 515,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#liveInfoEditForm").form("validate")) {
					//验证表单 
					if(!$("#liveInfoEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#liveInfoEditForm").form({
						    url:"LiveInfo/" + $("#liveInfo_liveInfoId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#liveInfoEditForm").form("validate"))  {
				                	$.messager.progress({
										text : "正在提交数据中...",
									});
				                	return true;
				                } else { 
				                    return false; 
				                }
						    },
						    success:function(data){
						    	$.messager.progress("close");
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#liveInfoEditDiv").dialog("close");
			                        liveInfo_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#liveInfoEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#liveInfoEditDiv").dialog("close");
				$("#liveInfoEditForm").form("reset"); 
			},
		}],
	});
});

function initLiveInfoManageTool() {
	liveInfo_manage_tool = {
		init: function() {
			$.ajax({
				url : "Student/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#studentObj_studentNumber_query").combobox({ 
					    valueField:"studentNumber",
					    textField:"studentName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{studentNumber:"",studentName:"不限制"});
					$("#studentObj_studentNumber_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "RoomInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#roomObj_roomId_query").combobox({ 
					    valueField:"roomId",
					    textField:"roomName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{roomId:0,roomName:"不限制"});
					$("#roomObj_roomId_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#liveInfo_manage").datagrid("reload");
		},
		redo : function () {
			$("#liveInfo_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#liveInfo_manage").datagrid("options").queryParams;
			queryParams["studentObj.studentNumber"] = $("#studentObj_studentNumber_query").combobox("getValue");
			queryParams["roomObj.roomId"] = $("#roomObj_roomId_query").combobox("getValue");
			queryParams["liveDate"] = $("#liveDate").datebox("getValue"); 
			$("#liveInfo_manage").datagrid("options").queryParams=queryParams; 
			$("#liveInfo_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#liveInfoQueryForm").form({
			    url:"LiveInfo/OutToExcel",
			});
			//提交表单
			$("#liveInfoQueryForm").submit();
		},
		remove : function () {
			var rows = $("#liveInfo_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var liveInfoIds = [];
						for (var i = 0; i < rows.length; i ++) {
							liveInfoIds.push(rows[i].liveInfoId);
						}
						$.ajax({
							type : "POST",
							url : "LiveInfo/deletes",
							data : {
								liveInfoIds : liveInfoIds.join(","),
							},
							beforeSend : function () {
								$("#liveInfo_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#liveInfo_manage").datagrid("loaded");
									$("#liveInfo_manage").datagrid("load");
									$("#liveInfo_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#liveInfo_manage").datagrid("loaded");
									$("#liveInfo_manage").datagrid("load");
									$("#liveInfo_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#liveInfo_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "LiveInfo/" + rows[0].liveInfoId +  "/update",
					type : "get",
					data : {
						//liveInfoId : rows[0].liveInfoId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (liveInfo, response, status) {
						$.messager.progress("close");
						if (liveInfo) { 
							$("#liveInfoEditDiv").dialog("open");
							$("#liveInfo_liveInfoId_edit").val(liveInfo.liveInfoId);
							$("#liveInfo_liveInfoId_edit").validatebox({
								required : true,
								missingMessage : "请输入记录编号",
								editable: false
							});
							$("#liveInfo_studentObj_studentNumber_edit").combobox({
								url:"Student/listAll",
							    valueField:"studentNumber",
							    textField:"studentName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#liveInfo_studentObj_studentNumber_edit").combobox("select", liveInfo.studentObjPri);
									//var data = $("#liveInfo_studentObj_studentNumber_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#liveInfo_studentObj_studentNumber_edit").combobox("select", data[0].studentNumber);
						            //}
								}
							});
							$("#liveInfo_roomObj_roomId_edit").combobox({
								url:"RoomInfo/listAll",
							    valueField:"roomId",
							    textField:"roomName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#liveInfo_roomObj_roomId_edit").combobox("select", liveInfo.roomObjPri);
									//var data = $("#liveInfo_roomObj_roomId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#liveInfo_roomObj_roomId_edit").combobox("select", data[0].roomId);
						            //}
								}
							});
							$("#liveInfo_liveDate_edit").datebox({
								value: liveInfo.liveDate,
							    required: true,
							    showSeconds: true,
							});
							$("#liveInfo_liveMemo_edit").val(liveInfo.liveMemo);
						} else {
							$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}

var newsInfo_manage_tool = null; 
$(function () { 
	initNewsInfoManageTool(); //建立NewsInfo管理对象
	newsInfo_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#newsInfo_manage").datagrid({
		url : 'NewsInfo/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "newsId",
		sortOrder : "desc",
		toolbar : "#newsInfo_manage_tool",
		columns : [[
			{
				field : "newsId",
				title : "记录编号",
				width : 70,
			},
			{
				field : "roomObj",
				title : "寝室房间",
				width : 140,
			},
			{
				field : "infoTypeObj",
				title : "信息类型",
				width : 140,
			},
			{
				field : "infoTitle",
				title : "信息标题",
				width : 140,
			},
			{
				field : "infoDate",
				title : "信息日期",
				width : 140,
			},
		]],
	});

	$("#newsInfoEditDiv").dialog({
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
				if ($("#newsInfoEditForm").form("validate")) {
					//验证表单 
					if(!$("#newsInfoEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#newsInfoEditForm").form({
						    url:"NewsInfo/" + $("#newsInfo_newsId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#newsInfoEditForm").form("validate"))  {
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
			                        $("#newsInfoEditDiv").dialog("close");
			                        newsInfo_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#newsInfoEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#newsInfoEditDiv").dialog("close");
				$("#newsInfoEditForm").form("reset"); 
			},
		}],
	});
});

function initNewsInfoManageTool() {
	newsInfo_manage_tool = {
		init: function() {
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
			$.ajax({
				url : "IntoType/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#infoTypeObj_typeId_query").combobox({ 
					    valueField:"typeId",
					    textField:"infoTypeName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{typeId:0,infoTypeName:"不限制"});
					$("#infoTypeObj_typeId_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#newsInfo_manage").datagrid("reload");
		},
		redo : function () {
			$("#newsInfo_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#newsInfo_manage").datagrid("options").queryParams;
			queryParams["roomObj.roomId"] = $("#roomObj_roomId_query").combobox("getValue");
			queryParams["infoTypeObj.typeId"] = $("#infoTypeObj_typeId_query").combobox("getValue");
			queryParams["infoTitle"] = $("#infoTitle").val();
			queryParams["infoDate"] = $("#infoDate").datebox("getValue"); 
			$("#newsInfo_manage").datagrid("options").queryParams=queryParams; 
			$("#newsInfo_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#newsInfoQueryForm").form({
			    url:"NewsInfo/OutToExcel",
			});
			//提交表单
			$("#newsInfoQueryForm").submit();
		},
		remove : function () {
			var rows = $("#newsInfo_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var newsIds = [];
						for (var i = 0; i < rows.length; i ++) {
							newsIds.push(rows[i].newsId);
						}
						$.ajax({
							type : "POST",
							url : "NewsInfo/deletes",
							data : {
								newsIds : newsIds.join(","),
							},
							beforeSend : function () {
								$("#newsInfo_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#newsInfo_manage").datagrid("loaded");
									$("#newsInfo_manage").datagrid("load");
									$("#newsInfo_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#newsInfo_manage").datagrid("loaded");
									$("#newsInfo_manage").datagrid("load");
									$("#newsInfo_manage").datagrid("unselectAll");
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
			var rows = $("#newsInfo_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "NewsInfo/" + rows[0].newsId +  "/update",
					type : "get",
					data : {
						//newsId : rows[0].newsId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (newsInfo, response, status) {
						$.messager.progress("close");
						if (newsInfo) { 
							$("#newsInfoEditDiv").dialog("open");
							$("#newsInfo_newsId_edit").val(newsInfo.newsId);
							$("#newsInfo_newsId_edit").validatebox({
								required : true,
								missingMessage : "请输入记录编号",
								editable: false
							});
							$("#newsInfo_roomObj_roomId_edit").combobox({
								url:"RoomInfo/listAll",
							    valueField:"roomId",
							    textField:"roomName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#newsInfo_roomObj_roomId_edit").combobox("select", newsInfo.roomObjPri);
									//var data = $("#newsInfo_roomObj_roomId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#newsInfo_roomObj_roomId_edit").combobox("select", data[0].roomId);
						            //}
								}
							});
							$("#newsInfo_infoTypeObj_typeId_edit").combobox({
								url:"IntoType/listAll",
							    valueField:"typeId",
							    textField:"infoTypeName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#newsInfo_infoTypeObj_typeId_edit").combobox("select", newsInfo.infoTypeObjPri);
									//var data = $("#newsInfo_infoTypeObj_typeId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#newsInfo_infoTypeObj_typeId_edit").combobox("select", data[0].typeId);
						            //}
								}
							});
							$("#newsInfo_infoTitle_edit").val(newsInfo.infoTitle);
							$("#newsInfo_infoTitle_edit").validatebox({
								required : true,
								missingMessage : "请输入信息标题",
							});
							$("#newsInfo_infoContent_edit").val(newsInfo.infoContent);
							$("#newsInfo_infoContent_edit").validatebox({
								required : true,
								missingMessage : "请输入信息内容",
							});
							$("#newsInfo_infoDate_edit").datebox({
								value: newsInfo.infoDate,
							    required: true,
							    showSeconds: true,
							});
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

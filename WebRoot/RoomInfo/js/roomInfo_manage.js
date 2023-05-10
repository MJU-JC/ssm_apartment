var roomInfo_manage_tool = null; 
$(function () { 
	initRoomInfoManageTool(); //建立RoomInfo管理对象
	roomInfo_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#roomInfo_manage").datagrid({
		url : 'RoomInfo/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "roomId",
		sortOrder : "desc",
		toolbar : "#roomInfo_manage_tool",
		columns : [[
			{
				field : "roomId",
				title : "记录编号",
				width : 70,
			},
			{
				field : "buildingObj",
				title : "所在宿舍",
				width : 140,
			},
			{
				field : "roomName",
				title : "房间名称",
				width : 140,
			},
			{
				field : "roomTypeName",
				title : "房间类型",
				width : 140,
			},
			{
				field : "roomPrice",
				title : "房间价格(元/月)",
				width : 70,
			},
			{
				field : "totalBedNumber",
				title : "总床位",
				width : 70,
			},
			{
				field : "leftBedNum",
				title : "剩余床位",
				width : 70,
			},
			{
				field : "roomTelephone",
				title : "寝室电话",
				width : 140,
			},
		]],
	});

	$("#roomInfoEditDiv").dialog({
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
				if ($("#roomInfoEditForm").form("validate")) {
					//验证表单 
					if(!$("#roomInfoEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#roomInfoEditForm").form({
						    url:"RoomInfo/" + $("#roomInfo_roomId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#roomInfoEditForm").form("validate"))  {
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
			                        $("#roomInfoEditDiv").dialog("close");
			                        roomInfo_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#roomInfoEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#roomInfoEditDiv").dialog("close");
				$("#roomInfoEditForm").form("reset"); 
			},
		}],
	});
});

function initRoomInfoManageTool() {
	roomInfo_manage_tool = {
		init: function() {
			$.ajax({
				url : "BuildingInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#buildingObj_buildingId_query").combobox({ 
					    valueField:"buildingId",
					    textField:"buildingName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{buildingId:0,buildingName:"不限制"});
					$("#buildingObj_buildingId_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#roomInfo_manage").datagrid("reload");
		},
		redo : function () {
			$("#roomInfo_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#roomInfo_manage").datagrid("options").queryParams;
			queryParams["buildingObj.buildingId"] = $("#buildingObj_buildingId_query").combobox("getValue");
			queryParams["roomName"] = $("#roomName").val();
			queryParams["roomTypeName"] = $("#roomTypeName").val();
			$("#roomInfo_manage").datagrid("options").queryParams=queryParams; 
			$("#roomInfo_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#roomInfoQueryForm").form({
			    url:"RoomInfo/OutToExcel",
			});
			//提交表单
			$("#roomInfoQueryForm").submit();
		},
		remove : function () {
			var rows = $("#roomInfo_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var roomIds = [];
						for (var i = 0; i < rows.length; i ++) {
							roomIds.push(rows[i].roomId);
						}
						$.ajax({
							type : "POST",
							url : "RoomInfo/deletes",
							data : {
								roomIds : roomIds.join(","),
							},
							beforeSend : function () {
								$("#roomInfo_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#roomInfo_manage").datagrid("loaded");
									$("#roomInfo_manage").datagrid("load");
									$("#roomInfo_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#roomInfo_manage").datagrid("loaded");
									$("#roomInfo_manage").datagrid("load");
									$("#roomInfo_manage").datagrid("unselectAll");
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
			var rows = $("#roomInfo_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "RoomInfo/" + rows[0].roomId +  "/update",
					type : "get",
					data : {
						//roomId : rows[0].roomId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (roomInfo, response, status) {
						$.messager.progress("close");
						if (roomInfo) { 
							$("#roomInfoEditDiv").dialog("open");
							$("#roomInfo_roomId_edit").val(roomInfo.roomId);
							$("#roomInfo_roomId_edit").validatebox({
								required : true,
								missingMessage : "请输入记录编号",
								editable: false
							});
							$("#roomInfo_buildingObj_buildingId_edit").combobox({
								url:"BuildingInfo/listAll",
							    valueField:"buildingId",
							    textField:"buildingName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#roomInfo_buildingObj_buildingId_edit").combobox("select", roomInfo.buildingObjPri);
									//var data = $("#roomInfo_buildingObj_buildingId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#roomInfo_buildingObj_buildingId_edit").combobox("select", data[0].buildingId);
						            //}
								}
							});
							$("#roomInfo_roomName_edit").val(roomInfo.roomName);
							$("#roomInfo_roomName_edit").validatebox({
								required : true,
								missingMessage : "请输入房间名称",
							});
							$("#roomInfo_roomTypeName_edit").val(roomInfo.roomTypeName);
							$("#roomInfo_roomTypeName_edit").validatebox({
								required : true,
								missingMessage : "请输入房间类型",
							});
							$("#roomInfo_roomPrice_edit").val(roomInfo.roomPrice);
							$("#roomInfo_roomPrice_edit").validatebox({
								required : true,
								validType : "number",
								missingMessage : "请输入房间价格(元/月)",
								invalidMessage : "房间价格(元/月)输入不对",
							});
							$("#roomInfo_totalBedNumber_edit").val(roomInfo.totalBedNumber);
							$("#roomInfo_totalBedNumber_edit").validatebox({
								required : true,
								validType : "integer",
								missingMessage : "请输入总床位",
								invalidMessage : "总床位输入不对",
							});
							$("#roomInfo_leftBedNum_edit").val(roomInfo.leftBedNum);
							$("#roomInfo_leftBedNum_edit").validatebox({
								required : true,
								validType : "integer",
								missingMessage : "请输入剩余床位",
								invalidMessage : "剩余床位输入不对",
							});
							$("#roomInfo_roomTelephone_edit").val(roomInfo.roomTelephone);
							$("#roomInfo_roomMemo_edit").val(roomInfo.roomMemo);
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

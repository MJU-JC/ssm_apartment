var intoType_manage_tool = null; 
$(function () { 
	initIntoTypeManageTool(); //建立IntoType管理对象
	intoType_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#intoType_manage").datagrid({
		url : 'IntoType/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "typeId",
		sortOrder : "desc",
		toolbar : "#intoType_manage_tool",
		columns : [[
			{
				field : "typeId",
				title : "记录编号",
				width : 70,
			},
			{
				field : "infoTypeName",
				title : "信息类别",
				width : 140,
			},
		]],
	});

	$("#intoTypeEditDiv").dialog({
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
				if ($("#intoTypeEditForm").form("validate")) {
					//验证表单 
					if(!$("#intoTypeEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#intoTypeEditForm").form({
						    url:"IntoType/" + $("#intoType_typeId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#intoTypeEditForm").form("validate"))  {
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
			                        $("#intoTypeEditDiv").dialog("close");
			                        intoType_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#intoTypeEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#intoTypeEditDiv").dialog("close");
				$("#intoTypeEditForm").form("reset"); 
			},
		}],
	});
});

function initIntoTypeManageTool() {
	intoType_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#intoType_manage").datagrid("reload");
		},
		redo : function () {
			$("#intoType_manage").datagrid("unselectAll");
		},
		search: function() {
			$("#intoType_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#intoTypeQueryForm").form({
			    url:"IntoType/OutToExcel",
			});
			//提交表单
			$("#intoTypeQueryForm").submit();
		},
		remove : function () {
			var rows = $("#intoType_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var typeIds = [];
						for (var i = 0; i < rows.length; i ++) {
							typeIds.push(rows[i].typeId);
						}
						$.ajax({
							type : "POST",
							url : "IntoType/deletes",
							data : {
								typeIds : typeIds.join(","),
							},
							beforeSend : function () {
								$("#intoType_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#intoType_manage").datagrid("loaded");
									$("#intoType_manage").datagrid("load");
									$("#intoType_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#intoType_manage").datagrid("loaded");
									$("#intoType_manage").datagrid("load");
									$("#intoType_manage").datagrid("unselectAll");
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
			var rows = $("#intoType_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "IntoType/" + rows[0].typeId +  "/update",
					type : "get",
					data : {
						//typeId : rows[0].typeId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (intoType, response, status) {
						$.messager.progress("close");
						if (intoType) { 
							$("#intoTypeEditDiv").dialog("open");
							$("#intoType_typeId_edit").val(intoType.typeId);
							$("#intoType_typeId_edit").validatebox({
								required : true,
								missingMessage : "请输入记录编号",
								editable: false
							});
							$("#intoType_infoTypeName_edit").val(intoType.infoTypeName);
							$("#intoType_infoTypeName_edit").validatebox({
								required : true,
								missingMessage : "请输入信息类别",
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

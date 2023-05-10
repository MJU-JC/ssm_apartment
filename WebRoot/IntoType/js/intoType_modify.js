$(function () {
	$.ajax({
		url : "IntoType/" + $("#intoType_typeId_edit").val() + "/update",
		type : "get",
		data : {
			//typeId : $("#intoType_typeId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (intoType, response, status) {
			$.messager.progress("close");
			if (intoType) { 
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#intoTypeModifyButton").click(function(){ 
		if ($("#intoTypeEditForm").form("validate")) {
			$("#intoTypeEditForm").form({
			    url:"IntoType/" +  $("#intoType_typeId_edit").val() + "/update",
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
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#intoTypeEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});

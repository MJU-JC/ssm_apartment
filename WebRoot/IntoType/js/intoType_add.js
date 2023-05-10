$(function () {
	$("#intoType_infoTypeName").validatebox({
		required : true, 
		missingMessage : '请输入信息类别',
	});

	//单击添加按钮
	$("#intoTypeAddButton").click(function () {
		//验证表单 
		if(!$("#intoTypeAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#intoTypeAddForm").form({
			    url:"IntoType/add",
			    onSubmit: function(){
					if($("#intoTypeAddForm").form("validate"))  { 
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
                    //此处data={"Success":true}是字符串
                	var obj = jQuery.parseJSON(data); 
                    if(obj.success){ 
                        $.messager.alert("消息","保存成功！");
                        $(".messager-window").css("z-index",10000);
                        $("#intoTypeAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#intoTypeAddForm").submit();
		}
	});

	//单击清空按钮
	$("#intoTypeClearButton").click(function () { 
		$("#intoTypeAddForm").form("clear"); 
	});
});

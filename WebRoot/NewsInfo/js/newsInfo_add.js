$(function () {
	$("#newsInfo_roomObj_roomId").combobox({
	    url:'RoomInfo/listAll',
	    valueField: "roomId",
	    textField: "roomName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#newsInfo_roomObj_roomId").combobox("getData"); 
            if (data.length > 0) {
                $("#newsInfo_roomObj_roomId").combobox("select", data[0].roomId);
            }
        }
	});
	$("#newsInfo_infoTypeObj_typeId").combobox({
	    url:'IntoType/listAll',
	    valueField: "typeId",
	    textField: "infoTypeName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#newsInfo_infoTypeObj_typeId").combobox("getData"); 
            if (data.length > 0) {
                $("#newsInfo_infoTypeObj_typeId").combobox("select", data[0].typeId);
            }
        }
	});
	$("#newsInfo_infoTitle").validatebox({
		required : true, 
		missingMessage : '请输入信息标题',
	});

	$("#newsInfo_infoContent").validatebox({
		required : true, 
		missingMessage : '请输入信息内容',
	});

	$("#newsInfo_infoDate").datebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	//单击添加按钮
	$("#newsInfoAddButton").click(function () {
		//验证表单 
		if(!$("#newsInfoAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#newsInfoAddForm").form({
			    url:"NewsInfo/add",
			    onSubmit: function(){
					if($("#newsInfoAddForm").form("validate"))  { 
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
                        $("#newsInfoAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#newsInfoAddForm").submit();
		}
	});

	//单击清空按钮
	$("#newsInfoClearButton").click(function () { 
		$("#newsInfoAddForm").form("clear"); 
	});
});

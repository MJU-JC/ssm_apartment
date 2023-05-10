$(function () {
	$("#liveInfo_studentObj_studentNumber").combobox({
	    url:'Student/listAll',
	    valueField: "studentNumber",
	    textField: "studentName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#liveInfo_studentObj_studentNumber").combobox("getData"); 
            if (data.length > 0) {
                $("#liveInfo_studentObj_studentNumber").combobox("select", data[0].studentNumber);
            }
        }
	});
	$("#liveInfo_roomObj_roomId").combobox({
	    url:'RoomInfo/listAll',
	    valueField: "roomId",
	    textField: "roomName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#liveInfo_roomObj_roomId").combobox("getData"); 
            if (data.length > 0) {
                $("#liveInfo_roomObj_roomId").combobox("select", data[0].roomId);
            }
        }
	});
	$("#liveInfo_liveDate").datebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	//单击添加按钮
	$("#liveInfoAddButton").click(function () {
		//验证表单 
		if(!$("#liveInfoAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#liveInfoAddForm").form({
			    url:"LiveInfo/add",
			    onSubmit: function(){
					if($("#liveInfoAddForm").form("validate"))  { 
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
                        $("#liveInfoAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#liveInfoAddForm").submit();
		}
	});

	//单击清空按钮
	$("#liveInfoClearButton").click(function () { 
		$("#liveInfoAddForm").form("clear"); 
	});
});

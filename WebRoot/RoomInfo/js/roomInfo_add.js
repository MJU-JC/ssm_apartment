$(function () {
	$("#roomInfo_buildingObj_buildingId").combobox({
	    url:'BuildingInfo/listAll',
	    valueField: "buildingId",
	    textField: "buildingName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#roomInfo_buildingObj_buildingId").combobox("getData"); 
            if (data.length > 0) {
                $("#roomInfo_buildingObj_buildingId").combobox("select", data[0].buildingId);
            }
        }
	});
	$("#roomInfo_roomName").validatebox({
		required : true, 
		missingMessage : '请输入房间名称',
	});

	$("#roomInfo_roomTypeName").validatebox({
		required : true, 
		missingMessage : '请输入房间类型',
	});

	$("#roomInfo_roomPrice").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入房间价格(元/月)',
		invalidMessage : '房间价格(元/月)输入不对',
	});

	$("#roomInfo_totalBedNumber").validatebox({
		required : true,
		validType : "integer",
		missingMessage : '请输入总床位',
		invalidMessage : '总床位输入不对',
	});

	$("#roomInfo_leftBedNum").validatebox({
		required : true,
		validType : "integer",
		missingMessage : '请输入剩余床位',
		invalidMessage : '剩余床位输入不对',
	});

	//单击添加按钮
	$("#roomInfoAddButton").click(function () {
		//验证表单 
		if(!$("#roomInfoAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#roomInfoAddForm").form({
			    url:"RoomInfo/add",
			    onSubmit: function(){
					if($("#roomInfoAddForm").form("validate"))  { 
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
                        $("#roomInfoAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#roomInfoAddForm").submit();
		}
	});

	//单击清空按钮
	$("#roomInfoClearButton").click(function () { 
		$("#roomInfoAddForm").form("clear"); 
	});
});

$(function () {
	$.ajax({
		url : "RoomInfo/" + $("#roomInfo_roomId_edit").val() + "/update",
		type : "get",
		data : {
			//roomId : $("#roomInfo_roomId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (roomInfo, response, status) {
			$.messager.progress("close");
			if (roomInfo) { 
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#roomInfoModifyButton").click(function(){ 
		if ($("#roomInfoEditForm").form("validate")) {
			$("#roomInfoEditForm").form({
			    url:"RoomInfo/" +  $("#roomInfo_roomId_edit").val() + "/update",
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
			$("#roomInfoEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});

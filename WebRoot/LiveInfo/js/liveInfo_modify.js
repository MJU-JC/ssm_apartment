$(function () {
	$.ajax({
		url : "LiveInfo/" + $("#liveInfo_liveInfoId_edit").val() + "/update",
		type : "get",
		data : {
			//liveInfoId : $("#liveInfo_liveInfoId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (liveInfo, response, status) {
			$.messager.progress("close");
			if (liveInfo) { 
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#liveInfoModifyButton").click(function(){ 
		if ($("#liveInfoEditForm").form("validate")) {
			$("#liveInfoEditForm").form({
			    url:"LiveInfo/" +  $("#liveInfo_liveInfoId_edit").val() + "/update",
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
			$("#liveInfoEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});

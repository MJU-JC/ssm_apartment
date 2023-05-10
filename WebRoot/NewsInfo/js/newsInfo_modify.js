$(function () {
	$.ajax({
		url : "NewsInfo/" + $("#newsInfo_newsId_edit").val() + "/update",
		type : "get",
		data : {
			//newsId : $("#newsInfo_newsId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (newsInfo, response, status) {
			$.messager.progress("close");
			if (newsInfo) { 
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#newsInfoModifyButton").click(function(){ 
		if ($("#newsInfoEditForm").form("validate")) {
			$("#newsInfoEditForm").form({
			    url:"NewsInfo/" +  $("#newsInfo_newsId_edit").val() + "/update",
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
			$("#newsInfoEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});

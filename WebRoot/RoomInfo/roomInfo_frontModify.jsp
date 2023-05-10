<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.RoomInfo" %>
<%@ page import="com.chengxusheji.po.BuildingInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的buildingObj信息
    List<BuildingInfo> buildingInfoList = (List<BuildingInfo>)request.getAttribute("buildingInfoList");
    RoomInfo roomInfo = (RoomInfo)request.getAttribute("roomInfo");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改房间信息信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">房间信息信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="roomInfoEditForm" id="roomInfoEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="roomInfo_roomId_edit" class="col-md-3 text-right">记录编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="roomInfo_roomId_edit" name="roomInfo.roomId" class="form-control" placeholder="请输入记录编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="roomInfo_buildingObj_buildingId_edit" class="col-md-3 text-right">所在宿舍:</label>
		  	 <div class="col-md-9">
			    <select id="roomInfo_buildingObj_buildingId_edit" name="roomInfo.buildingObj.buildingId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="roomInfo_roomName_edit" class="col-md-3 text-right">房间名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="roomInfo_roomName_edit" name="roomInfo.roomName" class="form-control" placeholder="请输入房间名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="roomInfo_roomTypeName_edit" class="col-md-3 text-right">房间类型:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="roomInfo_roomTypeName_edit" name="roomInfo.roomTypeName" class="form-control" placeholder="请输入房间类型">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="roomInfo_roomPrice_edit" class="col-md-3 text-right">房间价格(元/月):</label>
		  	 <div class="col-md-9">
			    <input type="text" id="roomInfo_roomPrice_edit" name="roomInfo.roomPrice" class="form-control" placeholder="请输入房间价格(元/月)">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="roomInfo_totalBedNumber_edit" class="col-md-3 text-right">总床位:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="roomInfo_totalBedNumber_edit" name="roomInfo.totalBedNumber" class="form-control" placeholder="请输入总床位">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="roomInfo_leftBedNum_edit" class="col-md-3 text-right">剩余床位:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="roomInfo_leftBedNum_edit" name="roomInfo.leftBedNum" class="form-control" placeholder="请输入剩余床位">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="roomInfo_roomTelephone_edit" class="col-md-3 text-right">寝室电话:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="roomInfo_roomTelephone_edit" name="roomInfo.roomTelephone" class="form-control" placeholder="请输入寝室电话">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="roomInfo_roomMemo_edit" class="col-md-3 text-right">附加信息:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="roomInfo_roomMemo_edit" name="roomInfo.roomMemo" class="form-control" placeholder="请输入附加信息">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxRoomInfoModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#roomInfoEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*弹出修改房间信息界面并初始化数据*/
function roomInfoEdit(roomId) {
	$.ajax({
		url :  basePath + "RoomInfo/" + roomId + "/update",
		type : "get",
		dataType: "json",
		success : function (roomInfo, response, status) {
			if (roomInfo) {
				$("#roomInfo_roomId_edit").val(roomInfo.roomId);
				$.ajax({
					url: basePath + "BuildingInfo/listAll",
					type: "get",
					success: function(buildingInfos,response,status) { 
						$("#roomInfo_buildingObj_buildingId_edit").empty();
						var html="";
		        		$(buildingInfos).each(function(i,buildingInfo){
		        			html += "<option value='" + buildingInfo.buildingId + "'>" + buildingInfo.buildingName + "</option>";
		        		});
		        		$("#roomInfo_buildingObj_buildingId_edit").html(html);
		        		$("#roomInfo_buildingObj_buildingId_edit").val(roomInfo.buildingObjPri);
					}
				});
				$("#roomInfo_roomName_edit").val(roomInfo.roomName);
				$("#roomInfo_roomTypeName_edit").val(roomInfo.roomTypeName);
				$("#roomInfo_roomPrice_edit").val(roomInfo.roomPrice);
				$("#roomInfo_totalBedNumber_edit").val(roomInfo.totalBedNumber);
				$("#roomInfo_leftBedNum_edit").val(roomInfo.leftBedNum);
				$("#roomInfo_roomTelephone_edit").val(roomInfo.roomTelephone);
				$("#roomInfo_roomMemo_edit").val(roomInfo.roomMemo);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交房间信息信息表单给服务器端修改*/
function ajaxRoomInfoModify() {
	$.ajax({
		url :  basePath + "RoomInfo/" + $("#roomInfo_roomId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#roomInfoEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#roomInfoQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
    roomInfoEdit("<%=request.getParameter("roomId")%>");
 })
 </script> 
</body>
</html>


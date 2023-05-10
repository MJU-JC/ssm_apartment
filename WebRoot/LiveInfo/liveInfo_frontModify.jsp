<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.LiveInfo" %>
<%@ page import="com.chengxusheji.po.RoomInfo" %>
<%@ page import="com.chengxusheji.po.Student" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的roomObj信息
    List<RoomInfo> roomInfoList = (List<RoomInfo>)request.getAttribute("roomInfoList");
    //获取所有的studentObj信息
    List<Student> studentList = (List<Student>)request.getAttribute("studentList");
    LiveInfo liveInfo = (LiveInfo)request.getAttribute("liveInfo");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改住宿信息信息</TITLE>
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
  		<li class="active">住宿信息信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="liveInfoEditForm" id="liveInfoEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="liveInfo_liveInfoId_edit" class="col-md-3 text-right">记录编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="liveInfo_liveInfoId_edit" name="liveInfo.liveInfoId" class="form-control" placeholder="请输入记录编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="liveInfo_studentObj_studentNumber_edit" class="col-md-3 text-right">学生:</label>
		  	 <div class="col-md-9">
			    <select id="liveInfo_studentObj_studentNumber_edit" name="liveInfo.studentObj.studentNumber" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="liveInfo_roomObj_roomId_edit" class="col-md-3 text-right">所在房间:</label>
		  	 <div class="col-md-9">
			    <select id="liveInfo_roomObj_roomId_edit" name="liveInfo.roomObj.roomId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="liveInfo_liveDate_edit" class="col-md-3 text-right">入住日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date liveInfo_liveDate_edit col-md-12" data-link-field="liveInfo_liveDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="liveInfo_liveDate_edit" name="liveInfo.liveDate" size="16" type="text" value="" placeholder="请选择入住日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="liveInfo_liveMemo_edit" class="col-md-3 text-right">附加信息:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="liveInfo_liveMemo_edit" name="liveInfo.liveMemo" class="form-control" placeholder="请输入附加信息">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxLiveInfoModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#liveInfoEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改住宿信息界面并初始化数据*/
function liveInfoEdit(liveInfoId) {
	$.ajax({
		url :  basePath + "LiveInfo/" + liveInfoId + "/update",
		type : "get",
		dataType: "json",
		success : function (liveInfo, response, status) {
			if (liveInfo) {
				$("#liveInfo_liveInfoId_edit").val(liveInfo.liveInfoId);
				$.ajax({
					url: basePath + "Student/listAll",
					type: "get",
					success: function(students,response,status) { 
						$("#liveInfo_studentObj_studentNumber_edit").empty();
						var html="";
		        		$(students).each(function(i,student){
		        			html += "<option value='" + student.studentNumber + "'>" + student.studentName + "</option>";
		        		});
		        		$("#liveInfo_studentObj_studentNumber_edit").html(html);
		        		$("#liveInfo_studentObj_studentNumber_edit").val(liveInfo.studentObjPri);
					}
				});
				$.ajax({
					url: basePath + "RoomInfo/listAll",
					type: "get",
					success: function(roomInfos,response,status) { 
						$("#liveInfo_roomObj_roomId_edit").empty();
						var html="";
		        		$(roomInfos).each(function(i,roomInfo){
		        			html += "<option value='" + roomInfo.roomId + "'>" + roomInfo.roomName + "</option>";
		        		});
		        		$("#liveInfo_roomObj_roomId_edit").html(html);
		        		$("#liveInfo_roomObj_roomId_edit").val(liveInfo.roomObjPri);
					}
				});
				$("#liveInfo_liveDate_edit").val(liveInfo.liveDate);
				$("#liveInfo_liveMemo_edit").val(liveInfo.liveMemo);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交住宿信息信息表单给服务器端修改*/
function ajaxLiveInfoModify() {
	$.ajax({
		url :  basePath + "LiveInfo/" + $("#liveInfo_liveInfoId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#liveInfoEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#liveInfoQueryForm").submit();
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
    /*入住日期组件*/
    $('.liveInfo_liveDate_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd',
    	minView: 2,
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    liveInfoEdit("<%=request.getParameter("liveInfoId")%>");
 })
 </script> 
</body>
</html>


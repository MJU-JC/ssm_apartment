<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.RoomInfo" %>
<%@ page import="com.chengxusheji.po.Student" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>住宿信息添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<div class="row">
		<div class="col-md-12 wow fadeInUp" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li role="presentation" ><a href="<%=basePath %>LiveInfo/frontlist">住宿信息列表</a></li>
			    	<li role="presentation" class="active"><a href="#liveInfoAdd" aria-controls="liveInfoAdd" role="tab" data-toggle="tab">添加住宿信息</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="liveInfoList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="liveInfoAdd"> 
				      	<form class="form-horizontal" name="liveInfoAddForm" id="liveInfoAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="liveInfo_studentObj_studentNumber" class="col-md-2 text-right">学生:</label>
						  	 <div class="col-md-8">
							    <select id="liveInfo_studentObj_studentNumber" name="liveInfo.studentObj.studentNumber" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="liveInfo_roomObj_roomId" class="col-md-2 text-right">所在房间:</label>
						  	 <div class="col-md-8">
							    <select id="liveInfo_roomObj_roomId" name="liveInfo.roomObj.roomId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="liveInfo_liveDateDiv" class="col-md-2 text-right">入住日期:</label>
						  	 <div class="col-md-8">
				                <div id="liveInfo_liveDateDiv" class="input-group date liveInfo_liveDate col-md-12" data-link-field="liveInfo_liveDate" data-link-format="yyyy-mm-dd">
				                    <input class="form-control" id="liveInfo_liveDate" name="liveInfo.liveDate" size="16" type="text" value="" placeholder="请选择入住日期" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="liveInfo_liveMemo" class="col-md-2 text-right">附加信息:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="liveInfo_liveMemo" name="liveInfo.liveMemo" class="form-control" placeholder="请输入附加信息">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxLiveInfoAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#liveInfoAddForm .form-group {margin:10px;}  </style>
					</div>
				</div>
			</div>
		</div>
	</div> 
</div>

<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script>
var basePath = "<%=basePath%>";
	//提交添加住宿信息信息
	function ajaxLiveInfoAdd() { 
		//提交之前先验证表单
		$("#liveInfoAddForm").data('bootstrapValidator').validate();
		if(!$("#liveInfoAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "LiveInfo/add",
			dataType : "json" , 
			data: new FormData($("#liveInfoAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#liveInfoAddForm").find("input").val("");
					$("#liveInfoAddForm").find("textarea").val("");
				} else {
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
	//验证住宿信息添加表单字段
	$('#liveInfoAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"liveInfo.liveDate": {
				validators: {
					notEmpty: {
						message: "入住日期不能为空",
					}
				}
			},
		}
	}); 
	//初始化学生下拉框值 
	$.ajax({
		url: basePath + "Student/listAll",
		type: "get",
		success: function(students,response,status) { 
			$("#liveInfo_studentObj_studentNumber").empty();
			var html="";
    		$(students).each(function(i,student){
    			html += "<option value='" + student.studentNumber + "'>" + student.studentName + "</option>";
    		});
    		$("#liveInfo_studentObj_studentNumber").html(html);
    	}
	});
	//初始化所在房间下拉框值 
	$.ajax({
		url: basePath + "RoomInfo/listAll",
		type: "get",
		success: function(roomInfos,response,status) { 
			$("#liveInfo_roomObj_roomId").empty();
			var html="";
    		$(roomInfos).each(function(i,roomInfo){
    			html += "<option value='" + roomInfo.roomId + "'>" + roomInfo.roomName + "</option>";
    		});
    		$("#liveInfo_roomObj_roomId").html(html);
    	}
	});
	//入住日期组件
	$('#liveInfo_liveDateDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd',
		minView: 2,
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#liveInfoAddForm').data('bootstrapValidator').updateStatus('liveInfo.liveDate', 'NOT_VALIDATED',null).validateField('liveInfo.liveDate');
	});
})
</script>
</body>
</html>

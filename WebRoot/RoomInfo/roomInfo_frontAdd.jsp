<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.BuildingInfo" %>
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
<title>房间信息添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>RoomInfo/frontlist">房间信息列表</a></li>
			    	<li role="presentation" class="active"><a href="#roomInfoAdd" aria-controls="roomInfoAdd" role="tab" data-toggle="tab">添加房间信息</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="roomInfoList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="roomInfoAdd"> 
				      	<form class="form-horizontal" name="roomInfoAddForm" id="roomInfoAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="roomInfo_buildingObj_buildingId" class="col-md-2 text-right">所在宿舍:</label>
						  	 <div class="col-md-8">
							    <select id="roomInfo_buildingObj_buildingId" name="roomInfo.buildingObj.buildingId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="roomInfo_roomName" class="col-md-2 text-right">房间名称:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="roomInfo_roomName" name="roomInfo.roomName" class="form-control" placeholder="请输入房间名称">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="roomInfo_roomTypeName" class="col-md-2 text-right">房间类型:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="roomInfo_roomTypeName" name="roomInfo.roomTypeName" class="form-control" placeholder="请输入房间类型">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="roomInfo_roomPrice" class="col-md-2 text-right">房间价格(元/月):</label>
						  	 <div class="col-md-8">
							    <input type="text" id="roomInfo_roomPrice" name="roomInfo.roomPrice" class="form-control" placeholder="请输入房间价格(元/月)">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="roomInfo_totalBedNumber" class="col-md-2 text-right">总床位:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="roomInfo_totalBedNumber" name="roomInfo.totalBedNumber" class="form-control" placeholder="请输入总床位">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="roomInfo_leftBedNum" class="col-md-2 text-right">剩余床位:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="roomInfo_leftBedNum" name="roomInfo.leftBedNum" class="form-control" placeholder="请输入剩余床位">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="roomInfo_roomTelephone" class="col-md-2 text-right">寝室电话:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="roomInfo_roomTelephone" name="roomInfo.roomTelephone" class="form-control" placeholder="请输入寝室电话">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="roomInfo_roomMemo" class="col-md-2 text-right">附加信息:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="roomInfo_roomMemo" name="roomInfo.roomMemo" class="form-control" placeholder="请输入附加信息">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxRoomInfoAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#roomInfoAddForm .form-group {margin:10px;}  </style>
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
	//提交添加房间信息信息
	function ajaxRoomInfoAdd() { 
		//提交之前先验证表单
		$("#roomInfoAddForm").data('bootstrapValidator').validate();
		if(!$("#roomInfoAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "RoomInfo/add",
			dataType : "json" , 
			data: new FormData($("#roomInfoAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#roomInfoAddForm").find("input").val("");
					$("#roomInfoAddForm").find("textarea").val("");
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
	//验证房间信息添加表单字段
	$('#roomInfoAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"roomInfo.roomName": {
				validators: {
					notEmpty: {
						message: "房间名称不能为空",
					}
				}
			},
			"roomInfo.roomTypeName": {
				validators: {
					notEmpty: {
						message: "房间类型不能为空",
					}
				}
			},
			"roomInfo.roomPrice": {
				validators: {
					notEmpty: {
						message: "房间价格(元/月)不能为空",
					},
					numeric: {
						message: "房间价格(元/月)不正确"
					}
				}
			},
			"roomInfo.totalBedNumber": {
				validators: {
					notEmpty: {
						message: "总床位不能为空",
					},
					integer: {
						message: "总床位不正确"
					}
				}
			},
			"roomInfo.leftBedNum": {
				validators: {
					notEmpty: {
						message: "剩余床位不能为空",
					},
					integer: {
						message: "剩余床位不正确"
					}
				}
			},
		}
	}); 
	//初始化所在宿舍下拉框值 
	$.ajax({
		url: basePath + "BuildingInfo/listAll",
		type: "get",
		success: function(buildingInfos,response,status) { 
			$("#roomInfo_buildingObj_buildingId").empty();
			var html="";
    		$(buildingInfos).each(function(i,buildingInfo){
    			html += "<option value='" + buildingInfo.buildingId + "'>" + buildingInfo.buildingName + "</option>";
    		});
    		$("#roomInfo_buildingObj_buildingId").html(html);
    	}
	});
})
</script>
</body>
</html>

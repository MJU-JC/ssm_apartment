<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.LiveInfo" %>
<%@ page import="com.chengxusheji.po.RoomInfo" %>
<%@ page import="com.chengxusheji.po.Student" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<LiveInfo> liveInfoList = (List<LiveInfo>)request.getAttribute("liveInfoList");
    //获取所有的roomObj信息
    List<RoomInfo> roomInfoList = (List<RoomInfo>)request.getAttribute("roomInfoList");
    //获取所有的studentObj信息
    List<Student> studentList = (List<Student>)request.getAttribute("studentList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    Student studentObj = (Student)request.getAttribute("studentObj");
    RoomInfo roomObj = (RoomInfo)request.getAttribute("roomObj");
    String liveDate = (String)request.getAttribute("liveDate"); //入住日期查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>住宿信息查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#liveInfoListPanel" aria-controls="liveInfoListPanel" role="tab" data-toggle="tab">住宿信息列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>LiveInfo/liveInfo_frontAdd.jsp" style="display:none;">添加住宿信息</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="liveInfoListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>记录编号</td><td>学生</td><td>所在房间</td><td>入住日期</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<liveInfoList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		LiveInfo liveInfo = liveInfoList.get(i); //获取到住宿信息对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=liveInfo.getLiveInfoId() %></td>
 											<td><%=liveInfo.getStudentObj().getStudentName() %></td>
 											<td><%=liveInfo.getRoomObj().getRoomName() %></td>
 											<td><%=liveInfo.getLiveDate() %></td>
 											<td>
 												<a href="<%=basePath  %>LiveInfo/<%=liveInfo.getLiveInfoId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="liveInfoEdit('<%=liveInfo.getLiveInfoId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="liveInfoDelete('<%=liveInfo.getLiveInfoId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

				    		<div class="row">
					            <div class="col-md-12">
						            <nav class="pull-left">
						                <ul class="pagination">
						                    <li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
						                     <%
						                    	int startPage = currentPage - 5;
						                    	int endPage = currentPage + 5;
						                    	if(startPage < 1) startPage=1;
						                    	if(endPage > totalPage) endPage = totalPage;
						                    	for(int i=startPage;i<=endPage;i++) {
						                    %>
						                    <li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
						                    <%  } %> 
						                    <li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						                </ul>
						            </nav>
						            <div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
					            </div>
				            </div> 
				    </div>
				</div>
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>住宿信息查询</h1>
		</div>
		<form name="liveInfoQueryForm" id="liveInfoQueryForm" action="<%=basePath %>LiveInfo/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="studentObj_studentNumber">学生：</label>
                <select id="studentObj_studentNumber" name="studentObj.studentNumber" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(Student studentTemp:studentList) {
	 					String selected = "";
 					if(studentObj!=null && studentObj.getStudentNumber()!=null && studentObj.getStudentNumber().equals(studentTemp.getStudentNumber()))
 						selected = "selected";
	 				%>
 				 <option value="<%=studentTemp.getStudentNumber() %>" <%=selected %>><%=studentTemp.getStudentName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="roomObj_roomId">所在房间：</label>
                <select id="roomObj_roomId" name="roomObj.roomId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(RoomInfo roomInfoTemp:roomInfoList) {
	 					String selected = "";
 					if(roomObj!=null && roomObj.getRoomId()!=null && roomObj.getRoomId().intValue()==roomInfoTemp.getRoomId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=roomInfoTemp.getRoomId() %>" <%=selected %>><%=roomInfoTemp.getRoomName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="liveDate">入住日期:</label>
				<input type="text" id="liveDate" name="liveDate" class="form-control"  placeholder="请选择入住日期" value="<%=liveDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="liveInfoEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;住宿信息信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
                <div class="input-group date liveInfo_liveDate_edit col-md-12" data-link-field="liveInfo_liveDate_edit"  data-link-format="yyyy-mm-dd">
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
		</form> 
	    <style>#liveInfoEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxLiveInfoModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.liveInfoQueryForm.currentPage.value = currentPage;
    document.liveInfoQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.liveInfoQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.liveInfoQueryForm.currentPage.value = pageValue;
    documentliveInfoQueryForm.submit();
}

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
				$('#liveInfoEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除住宿信息信息*/
function liveInfoDelete(liveInfoId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "LiveInfo/deletes",
			data : {
				liveInfoIds : liveInfoId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#liveInfoQueryForm").submit();
					//location.href= basePath + "LiveInfo/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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
})
</script>
</body>
</html>


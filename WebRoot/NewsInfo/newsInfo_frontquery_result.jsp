<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.NewsInfo" %>
<%@ page import="com.chengxusheji.po.IntoType" %>
<%@ page import="com.chengxusheji.po.RoomInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<NewsInfo> newsInfoList = (List<NewsInfo>)request.getAttribute("newsInfoList");
    //获取所有的infoTypeObj信息
    List<IntoType> intoTypeList = (List<IntoType>)request.getAttribute("intoTypeList");
    //获取所有的roomObj信息
    List<RoomInfo> roomInfoList = (List<RoomInfo>)request.getAttribute("roomInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    RoomInfo roomObj = (RoomInfo)request.getAttribute("roomObj");
    IntoType infoTypeObj = (IntoType)request.getAttribute("infoTypeObj");
    String infoTitle = (String)request.getAttribute("infoTitle"); //信息标题查询关键字
    String infoDate = (String)request.getAttribute("infoDate"); //信息日期查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>综合信息查询</title>
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
			    	<li role="presentation" class="active"><a href="#newsInfoListPanel" aria-controls="newsInfoListPanel" role="tab" data-toggle="tab">综合信息列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>NewsInfo/newsInfo_frontAdd.jsp" style="display:none;">添加综合信息</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="newsInfoListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>记录编号</td><td>寝室房间</td><td>信息类型</td><td>信息标题</td><td>信息日期</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<newsInfoList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		NewsInfo newsInfo = newsInfoList.get(i); //获取到综合信息对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=newsInfo.getNewsId() %></td>
 											<td><%=newsInfo.getRoomObj().getRoomName() %></td>
 											<td><%=newsInfo.getInfoTypeObj().getInfoTypeName() %></td>
 											<td><%=newsInfo.getInfoTitle() %></td>
 											<td><%=newsInfo.getInfoDate() %></td>
 											<td>
 												<a href="<%=basePath  %>NewsInfo/<%=newsInfo.getNewsId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="newsInfoEdit('<%=newsInfo.getNewsId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="newsInfoDelete('<%=newsInfo.getNewsId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
    		<h1>综合信息查询</h1>
		</div>
		<form name="newsInfoQueryForm" id="newsInfoQueryForm" action="<%=basePath %>NewsInfo/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="roomObj_roomId">寝室房间：</label>
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
            	<label for="infoTypeObj_typeId">信息类型：</label>
                <select id="infoTypeObj_typeId" name="infoTypeObj.typeId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(IntoType intoTypeTemp:intoTypeList) {
	 					String selected = "";
 					if(infoTypeObj!=null && infoTypeObj.getTypeId()!=null && infoTypeObj.getTypeId().intValue()==intoTypeTemp.getTypeId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=intoTypeTemp.getTypeId() %>" <%=selected %>><%=intoTypeTemp.getInfoTypeName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="infoTitle">信息标题:</label>
				<input type="text" id="infoTitle" name="infoTitle" value="<%=infoTitle %>" class="form-control" placeholder="请输入信息标题">
			</div>






			<div class="form-group">
				<label for="infoDate">信息日期:</label>
				<input type="text" id="infoDate" name="infoDate" class="form-control"  placeholder="请选择信息日期" value="<%=infoDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="newsInfoEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;综合信息信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="newsInfoEditForm" id="newsInfoEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="newsInfo_newsId_edit" class="col-md-3 text-right">记录编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="newsInfo_newsId_edit" name="newsInfo.newsId" class="form-control" placeholder="请输入记录编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="newsInfo_roomObj_roomId_edit" class="col-md-3 text-right">寝室房间:</label>
		  	 <div class="col-md-9">
			    <select id="newsInfo_roomObj_roomId_edit" name="newsInfo.roomObj.roomId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="newsInfo_infoTypeObj_typeId_edit" class="col-md-3 text-right">信息类型:</label>
		  	 <div class="col-md-9">
			    <select id="newsInfo_infoTypeObj_typeId_edit" name="newsInfo.infoTypeObj.typeId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="newsInfo_infoTitle_edit" class="col-md-3 text-right">信息标题:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="newsInfo_infoTitle_edit" name="newsInfo.infoTitle" class="form-control" placeholder="请输入信息标题">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="newsInfo_infoContent_edit" class="col-md-3 text-right">信息内容:</label>
		  	 <div class="col-md-9">
			    <textarea id="newsInfo_infoContent_edit" name="newsInfo.infoContent" rows="8" class="form-control" placeholder="请输入信息内容"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="newsInfo_infoDate_edit" class="col-md-3 text-right">信息日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date newsInfo_infoDate_edit col-md-12" data-link-field="newsInfo_infoDate_edit"  data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="newsInfo_infoDate_edit" name="newsInfo.infoDate" size="16" type="text" value="" placeholder="请选择信息日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		</form> 
	    <style>#newsInfoEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxNewsInfoModify();">提交</button>
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
    document.newsInfoQueryForm.currentPage.value = currentPage;
    document.newsInfoQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.newsInfoQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.newsInfoQueryForm.currentPage.value = pageValue;
    documentnewsInfoQueryForm.submit();
}

/*弹出修改综合信息界面并初始化数据*/
function newsInfoEdit(newsId) {
	$.ajax({
		url :  basePath + "NewsInfo/" + newsId + "/update",
		type : "get",
		dataType: "json",
		success : function (newsInfo, response, status) {
			if (newsInfo) {
				$("#newsInfo_newsId_edit").val(newsInfo.newsId);
				$.ajax({
					url: basePath + "RoomInfo/listAll",
					type: "get",
					success: function(roomInfos,response,status) { 
						$("#newsInfo_roomObj_roomId_edit").empty();
						var html="";
		        		$(roomInfos).each(function(i,roomInfo){
		        			html += "<option value='" + roomInfo.roomId + "'>" + roomInfo.roomName + "</option>";
		        		});
		        		$("#newsInfo_roomObj_roomId_edit").html(html);
		        		$("#newsInfo_roomObj_roomId_edit").val(newsInfo.roomObjPri);
					}
				});
				$.ajax({
					url: basePath + "IntoType/listAll",
					type: "get",
					success: function(intoTypes,response,status) { 
						$("#newsInfo_infoTypeObj_typeId_edit").empty();
						var html="";
		        		$(intoTypes).each(function(i,intoType){
		        			html += "<option value='" + intoType.typeId + "'>" + intoType.infoTypeName + "</option>";
		        		});
		        		$("#newsInfo_infoTypeObj_typeId_edit").html(html);
		        		$("#newsInfo_infoTypeObj_typeId_edit").val(newsInfo.infoTypeObjPri);
					}
				});
				$("#newsInfo_infoTitle_edit").val(newsInfo.infoTitle);
				$("#newsInfo_infoContent_edit").val(newsInfo.infoContent);
				$("#newsInfo_infoDate_edit").val(newsInfo.infoDate);
				$('#newsInfoEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除综合信息信息*/
function newsInfoDelete(newsId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "NewsInfo/deletes",
			data : {
				newsIds : newsId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#newsInfoQueryForm").submit();
					//location.href= basePath + "NewsInfo/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交综合信息信息表单给服务器端修改*/
function ajaxNewsInfoModify() {
	$.ajax({
		url :  basePath + "NewsInfo/" + $("#newsInfo_newsId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#newsInfoEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#newsInfoQueryForm").submit();
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

    /*信息日期组件*/
    $('.newsInfo_infoDate_edit').datetimepicker({
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


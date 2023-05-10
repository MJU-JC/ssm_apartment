<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/newsInfo.css" />
<div id="newsInfo_editDiv">
	<form id="newsInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsInfo_newsId_edit" name="newsInfo.newsId" value="<%=request.getParameter("newsId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">寝室房间:</span>
			<span class="inputControl">
				<input class="textbox"  id="newsInfo_roomObj_roomId_edit" name="newsInfo.roomObj.roomId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">信息类型:</span>
			<span class="inputControl">
				<input class="textbox"  id="newsInfo_infoTypeObj_typeId_edit" name="newsInfo.infoTypeObj.typeId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">信息标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsInfo_infoTitle_edit" name="newsInfo.infoTitle" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">信息内容:</span>
			<span class="inputControl">
				<textarea id="newsInfo_infoContent_edit" name="newsInfo.infoContent" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div>
			<span class="label">信息日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsInfo_infoDate_edit" name="newsInfo.infoDate" />

			</span>

		</div>
		<div class="operation">
			<a id="newsInfoModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/NewsInfo/js/newsInfo_modify.js"></script> 

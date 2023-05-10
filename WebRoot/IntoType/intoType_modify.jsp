<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/intoType.css" />
<div id="intoType_editDiv">
	<form id="intoTypeEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="intoType_typeId_edit" name="intoType.typeId" value="<%=request.getParameter("typeId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">信息类别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="intoType_infoTypeName_edit" name="intoType.infoTypeName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="intoTypeModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/IntoType/js/intoType_modify.js"></script> 

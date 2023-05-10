<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/intoType.css" />
<div id="intoTypeAddDiv">
	<form id="intoTypeAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">信息类别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="intoType_infoTypeName" name="intoType.infoTypeName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="intoTypeAddButton" class="easyui-linkbutton">添加</a>
			<a id="intoTypeClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/IntoType/js/intoType_add.js"></script> 

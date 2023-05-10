<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/newsInfo.css" />
<div id="newsInfoAddDiv">
	<form id="newsInfoAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">寝室房间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsInfo_roomObj_roomId" name="newsInfo.roomObj.roomId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">信息类型:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsInfo_infoTypeObj_typeId" name="newsInfo.infoTypeObj.typeId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">信息标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsInfo_infoTitle" name="newsInfo.infoTitle" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">信息内容:</span>
			<span class="inputControl">
				<textarea id="newsInfo_infoContent" name="newsInfo.infoContent" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div>
			<span class="label">信息日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsInfo_infoDate" name="newsInfo.infoDate" />

			</span>

		</div>
		<div class="operation">
			<a id="newsInfoAddButton" class="easyui-linkbutton">添加</a>
			<a id="newsInfoClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/NewsInfo/js/newsInfo_add.js"></script> 

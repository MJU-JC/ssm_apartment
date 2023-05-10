<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/liveInfo.css" />
<div id="liveInfoAddDiv">
	<form id="liveInfoAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">学生:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="liveInfo_studentObj_studentNumber" name="liveInfo.studentObj.studentNumber" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">所在房间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="liveInfo_roomObj_roomId" name="liveInfo.roomObj.roomId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">入住日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="liveInfo_liveDate" name="liveInfo.liveDate" />

			</span>

		</div>
		<div>
			<span class="label">附加信息:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="liveInfo_liveMemo" name="liveInfo.liveMemo" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="liveInfoAddButton" class="easyui-linkbutton">添加</a>
			<a id="liveInfoClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/LiveInfo/js/liveInfo_add.js"></script> 

<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/liveInfo.css" />
<div id="liveInfo_editDiv">
	<form id="liveInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="liveInfo_liveInfoId_edit" name="liveInfo.liveInfoId" value="<%=request.getParameter("liveInfoId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">学生:</span>
			<span class="inputControl">
				<input class="textbox"  id="liveInfo_studentObj_studentNumber_edit" name="liveInfo.studentObj.studentNumber" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">所在房间:</span>
			<span class="inputControl">
				<input class="textbox"  id="liveInfo_roomObj_roomId_edit" name="liveInfo.roomObj.roomId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">入住日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="liveInfo_liveDate_edit" name="liveInfo.liveDate" />

			</span>

		</div>
		<div>
			<span class="label">附加信息:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="liveInfo_liveMemo_edit" name="liveInfo.liveMemo" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="liveInfoModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/LiveInfo/js/liveInfo_modify.js"></script> 

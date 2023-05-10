<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/roomInfo.css" />
<div id="roomInfo_editDiv">
	<form id="roomInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="roomInfo_roomId_edit" name="roomInfo.roomId" value="<%=request.getParameter("roomId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">所在宿舍:</span>
			<span class="inputControl">
				<input class="textbox"  id="roomInfo_buildingObj_buildingId_edit" name="roomInfo.buildingObj.buildingId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">房间名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="roomInfo_roomName_edit" name="roomInfo.roomName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">房间类型:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="roomInfo_roomTypeName_edit" name="roomInfo.roomTypeName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">房间价格(元/月):</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="roomInfo_roomPrice_edit" name="roomInfo.roomPrice" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">总床位:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="roomInfo_totalBedNumber_edit" name="roomInfo.totalBedNumber" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">剩余床位:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="roomInfo_leftBedNum_edit" name="roomInfo.leftBedNum" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">寝室电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="roomInfo_roomTelephone_edit" name="roomInfo.roomTelephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">附加信息:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="roomInfo_roomMemo_edit" name="roomInfo.roomMemo" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="roomInfoModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/RoomInfo/js/roomInfo_modify.js"></script> 

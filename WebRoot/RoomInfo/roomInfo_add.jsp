<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/roomInfo.css" />
<div id="roomInfoAddDiv">
	<form id="roomInfoAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">所在宿舍:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="roomInfo_buildingObj_buildingId" name="roomInfo.buildingObj.buildingId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">房间名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="roomInfo_roomName" name="roomInfo.roomName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">房间类型:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="roomInfo_roomTypeName" name="roomInfo.roomTypeName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">房间价格(元/月):</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="roomInfo_roomPrice" name="roomInfo.roomPrice" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">总床位:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="roomInfo_totalBedNumber" name="roomInfo.totalBedNumber" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">剩余床位:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="roomInfo_leftBedNum" name="roomInfo.leftBedNum" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">寝室电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="roomInfo_roomTelephone" name="roomInfo.roomTelephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">附加信息:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="roomInfo_roomMemo" name="roomInfo.roomMemo" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="roomInfoAddButton" class="easyui-linkbutton">添加</a>
			<a id="roomInfoClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/RoomInfo/js/roomInfo_add.js"></script> 

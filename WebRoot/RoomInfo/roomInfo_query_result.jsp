<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/roomInfo.css" /> 

<div id="roomInfo_manage"></div>
<div id="roomInfo_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="roomInfo_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="roomInfo_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="roomInfo_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="roomInfo_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="roomInfo_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="roomInfoQueryForm" method="post">
			所在宿舍：<input class="textbox" type="text" id="buildingObj_buildingId_query" name="buildingObj.buildingId" style="width: auto"/>
			房间名称：<input type="text" class="textbox" id="roomName" name="roomName" style="width:110px" />
			房间类型：<input type="text" class="textbox" id="roomTypeName" name="roomTypeName" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="roomInfo_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="roomInfoEditDiv">
	<form id="roomInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="roomInfo_roomId_edit" name="roomInfo.roomId" style="width:200px" />
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
	</form>
</div>
<script type="text/javascript" src="RoomInfo/js/roomInfo_manage.js"></script> 

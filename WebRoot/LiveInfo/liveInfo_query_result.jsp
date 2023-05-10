<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/liveInfo.css" /> 

<div id="liveInfo_manage"></div>
<div id="liveInfo_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="liveInfo_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="liveInfo_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="liveInfo_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="liveInfo_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="liveInfo_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="liveInfoQueryForm" method="post">
			学生：<input class="textbox" type="text" id="studentObj_studentNumber_query" name="studentObj.studentNumber" style="width: auto"/>
			所在房间：<input class="textbox" type="text" id="roomObj_roomId_query" name="roomObj.roomId" style="width: auto"/>
			入住日期：<input type="text" id="liveDate" name="liveDate" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="liveInfo_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="liveInfoEditDiv">
	<form id="liveInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="liveInfo_liveInfoId_edit" name="liveInfo.liveInfoId" style="width:200px" />
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
	</form>
</div>
<script type="text/javascript" src="LiveInfo/js/liveInfo_manage.js"></script> 

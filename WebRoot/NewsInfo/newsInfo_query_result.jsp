<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/newsInfo.css" /> 

<div id="newsInfo_manage"></div>
<div id="newsInfo_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="newsInfo_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="newsInfo_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="newsInfo_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="newsInfo_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="newsInfo_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="newsInfoQueryForm" method="post">
			寝室房间：<input class="textbox" type="text" id="roomObj_roomId_query" name="roomObj.roomId" style="width: auto"/>
			信息类型：<input class="textbox" type="text" id="infoTypeObj_typeId_query" name="infoTypeObj.typeId" style="width: auto"/>
			信息标题：<input type="text" class="textbox" id="infoTitle" name="infoTitle" style="width:110px" />
			信息日期：<input type="text" id="infoDate" name="infoDate" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="newsInfo_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="newsInfoEditDiv">
	<form id="newsInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsInfo_newsId_edit" name="newsInfo.newsId" style="width:200px" />
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
	</form>
</div>
<script type="text/javascript" src="NewsInfo/js/newsInfo_manage.js"></script> 

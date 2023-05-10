<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/intoType.css" /> 

<div id="intoType_manage"></div>
<div id="intoType_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="intoType_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="intoType_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="intoType_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="intoType_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="intoType_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="intoTypeQueryForm" method="post">
		</form>	
	</div>
</div>

<div id="intoTypeEditDiv">
	<form id="intoTypeEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="intoType_typeId_edit" name="intoType.typeId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">信息类别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="intoType_infoTypeName_edit" name="intoType.infoTypeName" style="width:200px" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="IntoType/js/intoType_manage.js"></script> 

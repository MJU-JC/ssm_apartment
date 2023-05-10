package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.IntoType;

public interface IntoTypeMapper {
	/*添加信息类型信息*/
	public void addIntoType(IntoType intoType) throws Exception;

	/*按照查询条件分页查询信息类型记录*/
	public ArrayList<IntoType> queryIntoType(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有信息类型记录*/
	public ArrayList<IntoType> queryIntoTypeList(@Param("where") String where) throws Exception;

	/*按照查询条件的信息类型记录数*/
	public int queryIntoTypeCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条信息类型记录*/
	public IntoType getIntoType(int typeId) throws Exception;

	/*更新信息类型记录*/
	public void updateIntoType(IntoType intoType) throws Exception;

	/*删除信息类型记录*/
	public void deleteIntoType(int typeId) throws Exception;

}

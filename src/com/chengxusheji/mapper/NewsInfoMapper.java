package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.NewsInfo;

public interface NewsInfoMapper {
	/*添加综合信息信息*/
	public void addNewsInfo(NewsInfo newsInfo) throws Exception;

	/*按照查询条件分页查询综合信息记录*/
	public ArrayList<NewsInfo> queryNewsInfo(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有综合信息记录*/
	public ArrayList<NewsInfo> queryNewsInfoList(@Param("where") String where) throws Exception;

	/*按照查询条件的综合信息记录数*/
	public int queryNewsInfoCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条综合信息记录*/
	public NewsInfo getNewsInfo(int newsId) throws Exception;

	/*更新综合信息记录*/
	public void updateNewsInfo(NewsInfo newsInfo) throws Exception;

	/*删除综合信息记录*/
	public void deleteNewsInfo(int newsId) throws Exception;

}

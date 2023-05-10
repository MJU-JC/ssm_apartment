package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.LiveInfo;

public interface LiveInfoMapper {
	/*添加住宿信息信息*/
	public void addLiveInfo(LiveInfo liveInfo) throws Exception;

	/*按照查询条件分页查询住宿信息记录*/
	public ArrayList<LiveInfo> queryLiveInfo(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有住宿信息记录*/
	public ArrayList<LiveInfo> queryLiveInfoList(@Param("where") String where) throws Exception;

	/*按照查询条件的住宿信息记录数*/
	public int queryLiveInfoCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条住宿信息记录*/
	public LiveInfo getLiveInfo(int liveInfoId) throws Exception;

	/*更新住宿信息记录*/
	public void updateLiveInfo(LiveInfo liveInfo) throws Exception;

	/*删除住宿信息记录*/
	public void deleteLiveInfo(int liveInfoId) throws Exception;

}

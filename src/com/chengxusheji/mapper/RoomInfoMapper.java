package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.RoomInfo;

public interface RoomInfoMapper {
	/*添加房间信息信息*/
	public void addRoomInfo(RoomInfo roomInfo) throws Exception;

	/*按照查询条件分页查询房间信息记录*/
	public ArrayList<RoomInfo> queryRoomInfo(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有房间信息记录*/
	public ArrayList<RoomInfo> queryRoomInfoList(@Param("where") String where) throws Exception;

	/*按照查询条件的房间信息记录数*/
	public int queryRoomInfoCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条房间信息记录*/
	public RoomInfo getRoomInfo(int roomId) throws Exception;

	/*更新房间信息记录*/
	public void updateRoomInfo(RoomInfo roomInfo) throws Exception;

	/*删除房间信息记录*/
	public void deleteRoomInfo(int roomId) throws Exception;

}

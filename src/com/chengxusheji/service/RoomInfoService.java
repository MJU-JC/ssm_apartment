package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.BuildingInfo;
import com.chengxusheji.po.RoomInfo;

import com.chengxusheji.mapper.RoomInfoMapper;
@Service
public class RoomInfoService {

	@Resource RoomInfoMapper roomInfoMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加房间信息记录*/
    public void addRoomInfo(RoomInfo roomInfo) throws Exception {
    	roomInfoMapper.addRoomInfo(roomInfo);
    }

    /*按照查询条件分页查询房间信息记录*/
    public ArrayList<RoomInfo> queryRoomInfo(BuildingInfo buildingObj,String roomName,String roomTypeName,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != buildingObj && buildingObj.getBuildingId()!= null && buildingObj.getBuildingId()!= 0)  where += " and t_roomInfo.buildingObj=" + buildingObj.getBuildingId();
    	if(!roomName.equals("")) where = where + " and t_roomInfo.roomName like '%" + roomName + "%'";
    	if(!roomTypeName.equals("")) where = where + " and t_roomInfo.roomTypeName like '%" + roomTypeName + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return roomInfoMapper.queryRoomInfo(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<RoomInfo> queryRoomInfo(BuildingInfo buildingObj,String roomName,String roomTypeName) throws Exception  { 
     	String where = "where 1=1";
    	if(null != buildingObj && buildingObj.getBuildingId()!= null && buildingObj.getBuildingId()!= 0)  where += " and t_roomInfo.buildingObj=" + buildingObj.getBuildingId();
    	if(!roomName.equals("")) where = where + " and t_roomInfo.roomName like '%" + roomName + "%'";
    	if(!roomTypeName.equals("")) where = where + " and t_roomInfo.roomTypeName like '%" + roomTypeName + "%'";
    	return roomInfoMapper.queryRoomInfoList(where);
    }

    /*查询所有房间信息记录*/
    public ArrayList<RoomInfo> queryAllRoomInfo()  throws Exception {
        return roomInfoMapper.queryRoomInfoList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(BuildingInfo buildingObj,String roomName,String roomTypeName) throws Exception {
     	String where = "where 1=1";
    	if(null != buildingObj && buildingObj.getBuildingId()!= null && buildingObj.getBuildingId()!= 0)  where += " and t_roomInfo.buildingObj=" + buildingObj.getBuildingId();
    	if(!roomName.equals("")) where = where + " and t_roomInfo.roomName like '%" + roomName + "%'";
    	if(!roomTypeName.equals("")) where = where + " and t_roomInfo.roomTypeName like '%" + roomTypeName + "%'";
        recordNumber = roomInfoMapper.queryRoomInfoCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取房间信息记录*/
    public RoomInfo getRoomInfo(int roomId) throws Exception  {
        RoomInfo roomInfo = roomInfoMapper.getRoomInfo(roomId);
        return roomInfo;
    }

    /*更新房间信息记录*/
    public void updateRoomInfo(RoomInfo roomInfo) throws Exception {
        roomInfoMapper.updateRoomInfo(roomInfo);
    }

    /*删除一条房间信息记录*/
    public void deleteRoomInfo (int roomId) throws Exception {
        roomInfoMapper.deleteRoomInfo(roomId);
    }

    /*删除多条房间信息信息*/
    public int deleteRoomInfos (String roomIds) throws Exception {
    	String _roomIds[] = roomIds.split(",");
    	for(String _roomId: _roomIds) {
    		roomInfoMapper.deleteRoomInfo(Integer.parseInt(_roomId));
    	}
    	return _roomIds.length;
    }
}

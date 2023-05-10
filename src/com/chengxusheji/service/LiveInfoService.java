package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Student;
import com.chengxusheji.po.RoomInfo;
import com.chengxusheji.po.LiveInfo;

import com.chengxusheji.mapper.LiveInfoMapper;
@Service
public class LiveInfoService {

	@Resource LiveInfoMapper liveInfoMapper;
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

    /*添加住宿信息记录*/
    public void addLiveInfo(LiveInfo liveInfo) throws Exception {
    	liveInfoMapper.addLiveInfo(liveInfo);
    }

    /*按照查询条件分页查询住宿信息记录*/
    public ArrayList<LiveInfo> queryLiveInfo(Student studentObj,RoomInfo roomObj,String liveDate,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != studentObj &&  studentObj.getStudentNumber() != null  && !studentObj.getStudentNumber().equals(""))  where += " and t_liveInfo.studentObj='" + studentObj.getStudentNumber() + "'";
    	if(null != roomObj && roomObj.getRoomId()!= null && roomObj.getRoomId()!= 0)  where += " and t_liveInfo.roomObj=" + roomObj.getRoomId();
    	if(!liveDate.equals("")) where = where + " and t_liveInfo.liveDate like '%" + liveDate + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return liveInfoMapper.queryLiveInfo(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<LiveInfo> queryLiveInfo(Student studentObj,RoomInfo roomObj,String liveDate) throws Exception  { 
     	String where = "where 1=1";
    	if(null != studentObj &&  studentObj.getStudentNumber() != null && !studentObj.getStudentNumber().equals(""))  where += " and t_liveInfo.studentObj='" + studentObj.getStudentNumber() + "'";
    	if(null != roomObj && roomObj.getRoomId()!= null && roomObj.getRoomId()!= 0)  where += " and t_liveInfo.roomObj=" + roomObj.getRoomId();
    	if(!liveDate.equals("")) where = where + " and t_liveInfo.liveDate like '%" + liveDate + "%'";
    	return liveInfoMapper.queryLiveInfoList(where);
    }

    /*查询所有住宿信息记录*/
    public ArrayList<LiveInfo> queryAllLiveInfo()  throws Exception {
        return liveInfoMapper.queryLiveInfoList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Student studentObj,RoomInfo roomObj,String liveDate) throws Exception {
     	String where = "where 1=1";
    	if(null != studentObj &&  studentObj.getStudentNumber() != null && !studentObj.getStudentNumber().equals(""))  where += " and t_liveInfo.studentObj='" + studentObj.getStudentNumber() + "'";
    	if(null != roomObj && roomObj.getRoomId()!= null && roomObj.getRoomId()!= 0)  where += " and t_liveInfo.roomObj=" + roomObj.getRoomId();
    	if(!liveDate.equals("")) where = where + " and t_liveInfo.liveDate like '%" + liveDate + "%'";
        recordNumber = liveInfoMapper.queryLiveInfoCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取住宿信息记录*/
    public LiveInfo getLiveInfo(int liveInfoId) throws Exception  {
        LiveInfo liveInfo = liveInfoMapper.getLiveInfo(liveInfoId);
        return liveInfo;
    }

    /*更新住宿信息记录*/
    public void updateLiveInfo(LiveInfo liveInfo) throws Exception {
        liveInfoMapper.updateLiveInfo(liveInfo);
    }

    /*删除一条住宿信息记录*/
    public void deleteLiveInfo (int liveInfoId) throws Exception {
        liveInfoMapper.deleteLiveInfo(liveInfoId);
    }

    /*删除多条住宿信息信息*/
    public int deleteLiveInfos (String liveInfoIds) throws Exception {
    	String _liveInfoIds[] = liveInfoIds.split(",");
    	for(String _liveInfoId: _liveInfoIds) {
    		liveInfoMapper.deleteLiveInfo(Integer.parseInt(_liveInfoId));
    	}
    	return _liveInfoIds.length;
    }
}

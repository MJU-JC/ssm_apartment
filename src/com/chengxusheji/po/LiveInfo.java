package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class LiveInfo {
    /*记录编号*/
    private Integer liveInfoId;
    public Integer getLiveInfoId(){
        return liveInfoId;
    }
    public void setLiveInfoId(Integer liveInfoId){
        this.liveInfoId = liveInfoId;
    }

    /*学生*/
    private Student studentObj;
    public Student getStudentObj() {
        return studentObj;
    }
    public void setStudentObj(Student studentObj) {
        this.studentObj = studentObj;
    }

    /*所在房间*/
    private RoomInfo roomObj;
    public RoomInfo getRoomObj() {
        return roomObj;
    }
    public void setRoomObj(RoomInfo roomObj) {
        this.roomObj = roomObj;
    }

    /*入住日期*/
    @NotEmpty(message="入住日期不能为空")
    private String liveDate;
    public String getLiveDate() {
        return liveDate;
    }
    public void setLiveDate(String liveDate) {
        this.liveDate = liveDate;
    }

    /*附加信息*/
    private String liveMemo;
    public String getLiveMemo() {
        return liveMemo;
    }
    public void setLiveMemo(String liveMemo) {
        this.liveMemo = liveMemo;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonLiveInfo=new JSONObject(); 
		jsonLiveInfo.accumulate("liveInfoId", this.getLiveInfoId());
		jsonLiveInfo.accumulate("studentObj", this.getStudentObj().getStudentName());
		jsonLiveInfo.accumulate("studentObjPri", this.getStudentObj().getStudentNumber());
		jsonLiveInfo.accumulate("roomObj", this.getRoomObj().getRoomName());
		jsonLiveInfo.accumulate("roomObjPri", this.getRoomObj().getRoomId());
		jsonLiveInfo.accumulate("liveDate", this.getLiveDate().length()>19?this.getLiveDate().substring(0,19):this.getLiveDate());
		jsonLiveInfo.accumulate("liveMemo", this.getLiveMemo());
		return jsonLiveInfo;
    }}
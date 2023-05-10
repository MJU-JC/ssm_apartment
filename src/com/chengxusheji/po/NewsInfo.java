package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class NewsInfo {
    /*记录编号*/
    private Integer newsId;
    public Integer getNewsId(){
        return newsId;
    }
    public void setNewsId(Integer newsId){
        this.newsId = newsId;
    }

    /*寝室房间*/
    private RoomInfo roomObj;
    public RoomInfo getRoomObj() {
        return roomObj;
    }
    public void setRoomObj(RoomInfo roomObj) {
        this.roomObj = roomObj;
    }

    /*信息类型*/
    private IntoType infoTypeObj;
    public IntoType getInfoTypeObj() {
        return infoTypeObj;
    }
    public void setInfoTypeObj(IntoType infoTypeObj) {
        this.infoTypeObj = infoTypeObj;
    }

    /*信息标题*/
    @NotEmpty(message="信息标题不能为空")
    private String infoTitle;
    public String getInfoTitle() {
        return infoTitle;
    }
    public void setInfoTitle(String infoTitle) {
        this.infoTitle = infoTitle;
    }

    /*信息内容*/
    @NotEmpty(message="信息内容不能为空")
    private String infoContent;
    public String getInfoContent() {
        return infoContent;
    }
    public void setInfoContent(String infoContent) {
        this.infoContent = infoContent;
    }

    /*信息日期*/
    @NotEmpty(message="信息日期不能为空")
    private String infoDate;
    public String getInfoDate() {
        return infoDate;
    }
    public void setInfoDate(String infoDate) {
        this.infoDate = infoDate;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonNewsInfo=new JSONObject(); 
		jsonNewsInfo.accumulate("newsId", this.getNewsId());
		jsonNewsInfo.accumulate("roomObj", this.getRoomObj().getRoomName());
		jsonNewsInfo.accumulate("roomObjPri", this.getRoomObj().getRoomId());
		jsonNewsInfo.accumulate("infoTypeObj", this.getInfoTypeObj().getInfoTypeName());
		jsonNewsInfo.accumulate("infoTypeObjPri", this.getInfoTypeObj().getTypeId());
		jsonNewsInfo.accumulate("infoTitle", this.getInfoTitle());
		jsonNewsInfo.accumulate("infoContent", this.getInfoContent());
		jsonNewsInfo.accumulate("infoDate", this.getInfoDate().length()>19?this.getInfoDate().substring(0,19):this.getInfoDate());
		return jsonNewsInfo;
    }}
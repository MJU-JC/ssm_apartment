package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class RoomInfo {
    /*记录编号*/
    private Integer roomId;
    public Integer getRoomId(){
        return roomId;
    }
    public void setRoomId(Integer roomId){
        this.roomId = roomId;
    }

    /*所在宿舍*/
    private BuildingInfo buildingObj;
    public BuildingInfo getBuildingObj() {
        return buildingObj;
    }
    public void setBuildingObj(BuildingInfo buildingObj) {
        this.buildingObj = buildingObj;
    }

    /*房间名称*/
    @NotEmpty(message="房间名称不能为空")
    private String roomName;
    public String getRoomName() {
        return roomName;
    }
    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    /*房间类型*/
    @NotEmpty(message="房间类型不能为空")
    private String roomTypeName;
    public String getRoomTypeName() {
        return roomTypeName;
    }
    public void setRoomTypeName(String roomTypeName) {
        this.roomTypeName = roomTypeName;
    }

    /*房间价格(元/月)*/
    @NotNull(message="必须输入房间价格(元/月)")
    private Float roomPrice;
    public Float getRoomPrice() {
        return roomPrice;
    }
    public void setRoomPrice(Float roomPrice) {
        this.roomPrice = roomPrice;
    }

    /*总床位*/
    @NotNull(message="必须输入总床位")
    private Integer totalBedNumber;
    public Integer getTotalBedNumber() {
        return totalBedNumber;
    }
    public void setTotalBedNumber(Integer totalBedNumber) {
        this.totalBedNumber = totalBedNumber;
    }

    /*剩余床位*/
    @NotNull(message="必须输入剩余床位")
    private Integer leftBedNum;
    public Integer getLeftBedNum() {
        return leftBedNum;
    }
    public void setLeftBedNum(Integer leftBedNum) {
        this.leftBedNum = leftBedNum;
    }

    /*寝室电话*/
    private String roomTelephone;
    public String getRoomTelephone() {
        return roomTelephone;
    }
    public void setRoomTelephone(String roomTelephone) {
        this.roomTelephone = roomTelephone;
    }

    /*附加信息*/
    private String roomMemo;
    public String getRoomMemo() {
        return roomMemo;
    }
    public void setRoomMemo(String roomMemo) {
        this.roomMemo = roomMemo;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonRoomInfo=new JSONObject(); 
		jsonRoomInfo.accumulate("roomId", this.getRoomId());
		jsonRoomInfo.accumulate("buildingObj", this.getBuildingObj().getBuildingName());
		jsonRoomInfo.accumulate("buildingObjPri", this.getBuildingObj().getBuildingId());
		jsonRoomInfo.accumulate("roomName", this.getRoomName());
		jsonRoomInfo.accumulate("roomTypeName", this.getRoomTypeName());
		jsonRoomInfo.accumulate("roomPrice", this.getRoomPrice());
		jsonRoomInfo.accumulate("totalBedNumber", this.getTotalBedNumber());
		jsonRoomInfo.accumulate("leftBedNum", this.getLeftBedNum());
		jsonRoomInfo.accumulate("roomTelephone", this.getRoomTelephone());
		jsonRoomInfo.accumulate("roomMemo", this.getRoomMemo());
		return jsonRoomInfo;
    }}
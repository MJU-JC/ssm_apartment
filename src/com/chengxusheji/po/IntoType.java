package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class IntoType {
    /*记录编号*/
    private Integer typeId;
    public Integer getTypeId(){
        return typeId;
    }
    public void setTypeId(Integer typeId){
        this.typeId = typeId;
    }

    /*信息类别*/
    @NotEmpty(message="信息类别不能为空")
    private String infoTypeName;
    public String getInfoTypeName() {
        return infoTypeName;
    }
    public void setInfoTypeName(String infoTypeName) {
        this.infoTypeName = infoTypeName;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonIntoType=new JSONObject(); 
		jsonIntoType.accumulate("typeId", this.getTypeId());
		jsonIntoType.accumulate("infoTypeName", this.getInfoTypeName());
		return jsonIntoType;
    }}
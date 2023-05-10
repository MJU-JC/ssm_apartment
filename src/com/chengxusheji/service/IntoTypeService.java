package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.IntoType;

import com.chengxusheji.mapper.IntoTypeMapper;
@Service
public class IntoTypeService {

	@Resource IntoTypeMapper intoTypeMapper;
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

    /*添加信息类型记录*/
    public void addIntoType(IntoType intoType) throws Exception {
    	intoTypeMapper.addIntoType(intoType);
    }

    /*按照查询条件分页查询信息类型记录*/
    public ArrayList<IntoType> queryIntoType(int currentPage) throws Exception { 
     	String where = "where 1=1";
    	int startIndex = (currentPage-1) * this.rows;
    	return intoTypeMapper.queryIntoType(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<IntoType> queryIntoType() throws Exception  { 
     	String where = "where 1=1";
    	return intoTypeMapper.queryIntoTypeList(where);
    }

    /*查询所有信息类型记录*/
    public ArrayList<IntoType> queryAllIntoType()  throws Exception {
        return intoTypeMapper.queryIntoTypeList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber() throws Exception {
     	String where = "where 1=1";
        recordNumber = intoTypeMapper.queryIntoTypeCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取信息类型记录*/
    public IntoType getIntoType(int typeId) throws Exception  {
        IntoType intoType = intoTypeMapper.getIntoType(typeId);
        return intoType;
    }

    /*更新信息类型记录*/
    public void updateIntoType(IntoType intoType) throws Exception {
        intoTypeMapper.updateIntoType(intoType);
    }

    /*删除一条信息类型记录*/
    public void deleteIntoType (int typeId) throws Exception {
        intoTypeMapper.deleteIntoType(typeId);
    }

    /*删除多条信息类型信息*/
    public int deleteIntoTypes (String typeIds) throws Exception {
    	String _typeIds[] = typeIds.split(",");
    	for(String _typeId: _typeIds) {
    		intoTypeMapper.deleteIntoType(Integer.parseInt(_typeId));
    	}
    	return _typeIds.length;
    }
}

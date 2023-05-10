package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.RoomInfoService;
import com.chengxusheji.po.RoomInfo;
import com.chengxusheji.service.BuildingInfoService;
import com.chengxusheji.po.BuildingInfo;

//RoomInfo管理控制层
@Controller
@RequestMapping("/RoomInfo")
public class RoomInfoController extends BaseController {

    /*业务层对象*/
    @Resource RoomInfoService roomInfoService;

    @Resource BuildingInfoService buildingInfoService;
	@InitBinder("buildingObj")
	public void initBinderbuildingObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("buildingObj.");
	}
	@InitBinder("roomInfo")
	public void initBinderRoomInfo(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("roomInfo.");
	}
	/*跳转到添加RoomInfo视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new RoomInfo());
		/*查询所有的BuildingInfo信息*/
		List<BuildingInfo> buildingInfoList = buildingInfoService.queryAllBuildingInfo();
		request.setAttribute("buildingInfoList", buildingInfoList);
		return "RoomInfo_add";
	}

	/*客户端ajax方式提交添加房间信息信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated RoomInfo roomInfo, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        roomInfoService.addRoomInfo(roomInfo);
        message = "房间信息添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询房间信息信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("buildingObj") BuildingInfo buildingObj,String roomName,String roomTypeName,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (roomName == null) roomName = "";
		if (roomTypeName == null) roomTypeName = "";
		if(rows != 0)roomInfoService.setRows(rows);
		List<RoomInfo> roomInfoList = roomInfoService.queryRoomInfo(buildingObj, roomName, roomTypeName, page);
	    /*计算总的页数和总的记录数*/
	    roomInfoService.queryTotalPageAndRecordNumber(buildingObj, roomName, roomTypeName);
	    /*获取到总的页码数目*/
	    int totalPage = roomInfoService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = roomInfoService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(RoomInfo roomInfo:roomInfoList) {
			JSONObject jsonRoomInfo = roomInfo.getJsonObject();
			jsonArray.put(jsonRoomInfo);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询房间信息信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<RoomInfo> roomInfoList = roomInfoService.queryAllRoomInfo();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(RoomInfo roomInfo:roomInfoList) {
			JSONObject jsonRoomInfo = new JSONObject();
			jsonRoomInfo.accumulate("roomId", roomInfo.getRoomId());
			jsonRoomInfo.accumulate("roomName", roomInfo.getRoomName());
			jsonArray.put(jsonRoomInfo);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询房间信息信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("buildingObj") BuildingInfo buildingObj,String roomName,String roomTypeName,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (roomName == null) roomName = "";
		if (roomTypeName == null) roomTypeName = "";
		List<RoomInfo> roomInfoList = roomInfoService.queryRoomInfo(buildingObj, roomName, roomTypeName, currentPage);
	    /*计算总的页数和总的记录数*/
	    roomInfoService.queryTotalPageAndRecordNumber(buildingObj, roomName, roomTypeName);
	    /*获取到总的页码数目*/
	    int totalPage = roomInfoService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = roomInfoService.getRecordNumber();
	    request.setAttribute("roomInfoList",  roomInfoList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("buildingObj", buildingObj);
	    request.setAttribute("roomName", roomName);
	    request.setAttribute("roomTypeName", roomTypeName);
	    List<BuildingInfo> buildingInfoList = buildingInfoService.queryAllBuildingInfo();
	    request.setAttribute("buildingInfoList", buildingInfoList);
		return "RoomInfo/roomInfo_frontquery_result"; 
	}

     /*前台查询RoomInfo信息*/
	@RequestMapping(value="/{roomId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer roomId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键roomId获取RoomInfo对象*/
        RoomInfo roomInfo = roomInfoService.getRoomInfo(roomId);

        List<BuildingInfo> buildingInfoList = buildingInfoService.queryAllBuildingInfo();
        request.setAttribute("buildingInfoList", buildingInfoList);
        request.setAttribute("roomInfo",  roomInfo);
        return "RoomInfo/roomInfo_frontshow";
	}

	/*ajax方式显示房间信息修改jsp视图页*/
	@RequestMapping(value="/{roomId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer roomId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键roomId获取RoomInfo对象*/
        RoomInfo roomInfo = roomInfoService.getRoomInfo(roomId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonRoomInfo = roomInfo.getJsonObject();
		out.println(jsonRoomInfo.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新房间信息信息*/
	@RequestMapping(value = "/{roomId}/update", method = RequestMethod.POST)
	public void update(@Validated RoomInfo roomInfo, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			roomInfoService.updateRoomInfo(roomInfo);
			message = "房间信息更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "房间信息更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除房间信息信息*/
	@RequestMapping(value="/{roomId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer roomId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  roomInfoService.deleteRoomInfo(roomId);
	            request.setAttribute("message", "房间信息删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "房间信息删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条房间信息记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String roomIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = roomInfoService.deleteRoomInfos(roomIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出房间信息信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("buildingObj") BuildingInfo buildingObj,String roomName,String roomTypeName, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(roomName == null) roomName = "";
        if(roomTypeName == null) roomTypeName = "";
        List<RoomInfo> roomInfoList = roomInfoService.queryRoomInfo(buildingObj,roomName,roomTypeName);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "RoomInfo信息记录"; 
        String[] headers = { "记录编号","所在宿舍","房间名称","房间类型","房间价格(元/月)","总床位","剩余床位","寝室电话"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<roomInfoList.size();i++) {
        	RoomInfo roomInfo = roomInfoList.get(i); 
        	dataset.add(new String[]{roomInfo.getRoomId() + "",roomInfo.getBuildingObj().getBuildingName(),roomInfo.getRoomName(),roomInfo.getRoomTypeName(),roomInfo.getRoomPrice() + "",roomInfo.getTotalBedNumber() + "",roomInfo.getLeftBedNum() + "",roomInfo.getRoomTelephone()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"RoomInfo.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}

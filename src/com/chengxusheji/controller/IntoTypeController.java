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
import com.chengxusheji.service.IntoTypeService;
import com.chengxusheji.po.IntoType;

//IntoType管理控制层
@Controller
@RequestMapping("/IntoType")
public class IntoTypeController extends BaseController {

    /*业务层对象*/
    @Resource IntoTypeService intoTypeService;

	@InitBinder("intoType")
	public void initBinderIntoType(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("intoType.");
	}
	/*跳转到添加IntoType视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new IntoType());
		return "IntoType_add";
	}

	/*客户端ajax方式提交添加信息类型信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated IntoType intoType, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        intoTypeService.addIntoType(intoType);
        message = "信息类型添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询信息类型信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if(rows != 0)intoTypeService.setRows(rows);
		List<IntoType> intoTypeList = intoTypeService.queryIntoType(page);
	    /*计算总的页数和总的记录数*/
	    intoTypeService.queryTotalPageAndRecordNumber();
	    /*获取到总的页码数目*/
	    int totalPage = intoTypeService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = intoTypeService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(IntoType intoType:intoTypeList) {
			JSONObject jsonIntoType = intoType.getJsonObject();
			jsonArray.put(jsonIntoType);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询信息类型信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<IntoType> intoTypeList = intoTypeService.queryAllIntoType();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(IntoType intoType:intoTypeList) {
			JSONObject jsonIntoType = new JSONObject();
			jsonIntoType.accumulate("typeId", intoType.getTypeId());
			jsonIntoType.accumulate("infoTypeName", intoType.getInfoTypeName());
			jsonArray.put(jsonIntoType);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询信息类型信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		List<IntoType> intoTypeList = intoTypeService.queryIntoType(currentPage);
	    /*计算总的页数和总的记录数*/
	    intoTypeService.queryTotalPageAndRecordNumber();
	    /*获取到总的页码数目*/
	    int totalPage = intoTypeService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = intoTypeService.getRecordNumber();
	    request.setAttribute("intoTypeList",  intoTypeList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
		return "IntoType/intoType_frontquery_result"; 
	}

     /*前台查询IntoType信息*/
	@RequestMapping(value="/{typeId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer typeId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键typeId获取IntoType对象*/
        IntoType intoType = intoTypeService.getIntoType(typeId);

        request.setAttribute("intoType",  intoType);
        return "IntoType/intoType_frontshow";
	}

	/*ajax方式显示信息类型修改jsp视图页*/
	@RequestMapping(value="/{typeId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer typeId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键typeId获取IntoType对象*/
        IntoType intoType = intoTypeService.getIntoType(typeId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonIntoType = intoType.getJsonObject();
		out.println(jsonIntoType.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新信息类型信息*/
	@RequestMapping(value = "/{typeId}/update", method = RequestMethod.POST)
	public void update(@Validated IntoType intoType, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			intoTypeService.updateIntoType(intoType);
			message = "信息类型更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "信息类型更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除信息类型信息*/
	@RequestMapping(value="/{typeId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer typeId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  intoTypeService.deleteIntoType(typeId);
	            request.setAttribute("message", "信息类型删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "信息类型删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条信息类型记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String typeIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = intoTypeService.deleteIntoTypes(typeIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出信息类型信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel( Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        List<IntoType> intoTypeList = intoTypeService.queryIntoType();
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "IntoType信息记录"; 
        String[] headers = { "记录编号","信息类别"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<intoTypeList.size();i++) {
        	IntoType intoType = intoTypeList.get(i); 
        	dataset.add(new String[]{intoType.getTypeId() + "",intoType.getInfoTypeName()});
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
			response.setHeader("Content-disposition","attachment; filename="+"IntoType.xls");//filename是下载的xls的名，建议最好用英文 
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

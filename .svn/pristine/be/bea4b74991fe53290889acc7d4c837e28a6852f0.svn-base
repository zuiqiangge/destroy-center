package cn.com.pengyue.web.action;

import java.awt.Toolkit;
import java.awt.datatransfer.Clipboard;
import java.awt.datatransfer.StringSelection;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;


import cn.com.pengyue.pojo.stock;
import cn.com.pengyue.service.IStockService;
import cn.com.pengyue.service.IUsersService;

import com.alibaba.druid.util.StringUtils;



@Controller
public class StockController {
	@javax.annotation.Resource
	private IStockService stockService;
	@javax.annotation.Resource
	private IUsersService userService;
	
	@RequestMapping("/listAllStock")
	public String listAll(Model model){
		model.addAttribute("list", stockService.listAll());
		model.addAttribute("user", userService.listAll());
		return "listAllStock";
	}
	
	@RequestMapping("/listAllStockByOrder")
	public String listAllStockByOrder(Model model,HttpServletRequest request) throws ParseException{
		stock stcok1=new stock();
		if(null!=request.getParameter("type")){
			String contactUnit = request.getParameter("contactUnit");
			String user=request.getParameter("userid");
			if(null!=user&&!(StringUtils.isEmpty(user))){
				int userId=Integer.parseInt(user);
				stcok1.setUserId(userId);
			}
			String types=request.getParameter("type");
			if(null!=types&&!(StringUtils.isEmpty(types))){
				int type=Integer.parseInt(types);
				stcok1.setType(type);
			}
			
			String dates=request.getParameter("stockDates");
			if(dates!=null&&!(StringUtils.isEmpty(dates))){
			
				SimpleDateFormat formatter=new SimpleDateFormat("yyyy/MM/dd");  
				Date stockDate=formatter.parse(dates);
				
				stcok1.setStockDate(stockDate);
			}
			
			String batchs=request.getParameter("batch");
			if(batchs!=null&&!(StringUtils.isEmpty(batchs))){
				int batch=Integer.parseInt(batchs);
				stcok1.setBatch(batch);
			}
			
			if(contactUnit!=null&&!(StringUtils.isEmpty(contactUnit))){
				stcok1.setContactUnit(contactUnit);
			}
		}
		
	
		model.addAttribute("list", stockService.listAllStockByOrder(stcok1));
		model.addAttribute("user", userService.listAll());
		return "listAllStock";
	}
	
	
	
	//异步获取data
	@RequestMapping("/ajaxGetStock")
	public void ajaxGetStock(Model model,HttpServletRequest request,HttpServletResponse response) throws ParseException{
		stock stcok1=new stock();
		if(null!=request.getParameter("type")){
			String contactUnit = request.getParameter("contactUnit");
			String user=request.getParameter("userid");
			if(null!=user&&!(StringUtils.isEmpty(user))){
				int userId=Integer.parseInt(user);
				stcok1.setUserId(userId);
			}
			String types=request.getParameter("type");
			if(null!=types&&!(StringUtils.isEmpty(types))){
				int type=Integer.parseInt(types);
				stcok1.setType(type);
			}
			
			String dates=request.getParameter("stockDates");
			if(dates!=null&&!(StringUtils.isEmpty(dates))){
			
				SimpleDateFormat formatter=new SimpleDateFormat("yyyy/MM/dd");  
				Date stockDate=formatter.parse(dates);
				
				stcok1.setStockDate(stockDate);
			}
			
			String batchs=request.getParameter("batch");
			if(batchs!=null&&!(StringUtils.isEmpty(batchs))){
				int batch=Integer.parseInt(batchs);
				stcok1.setBatch(batch);
			}
			
			if(contactUnit!=null&&!(StringUtils.isEmpty(contactUnit))){
				stcok1.setContactUnit(contactUnit);
			}
		}
		List<stock> list = stockService.listAllStockByOrder(stcok1);
		try {
			PrintWriter out =response.getWriter();
			JSONArray result = new JSONArray();
			result.addAll(list);
			out.print(result);
			out.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
	}
	
	
	//入库
	@RequestMapping("/addStock")
	public String addStock(stock pojo){
		stockService.save(pojo);
		return "listAllStock";
	}
	
	@RequestMapping("/ajaxAddStock")
	@ResponseBody
	public Object ajaxAddRole(stock pojo){
		stockService.save(pojo);
		return pojo;
	}
	@RequestMapping("/getStockById")
	public String getRoleById(Integer id,Model model){
		model.addAttribute("pojo", stockService.get(id));
		return "getStockById";
	}
	
	@RequestMapping("/updateStock")
	public String updateRole(stock pojo){
		stockService.update(pojo);
		return "updateStock";
	}
	
	
	@RequestMapping("/removeStock")
	public String removeRole(Integer[] id){
		stockService.delete(Arrays.asList(id));
		return "removeStock";
	}
	
	
	@RequestMapping("/ajaxGetStockById")
	@ResponseBody
	public Object ajaxGetRoleById(Integer id,Model model){
		return stockService.get(id);
	}
	
	@RequestMapping("/ajaxUpdateStock")
	@ResponseBody
	public Object ajaxUpdateRole(stock pojo){
		stockService.update(pojo);
		return pojo;
	}
	

	@RequestMapping("/ajaxRemoveStock")
	@ResponseBody
	public Object ajaxRemoveRole(Integer[] id){
		stockService.delete(Arrays.asList(id));
		return Arrays.asList(id);
	}
	
	/**
	 * 插入
	 */
	@RequestMapping("/insertStock")
	public String addUser(HttpServletRequest request,HttpServletResponse response){
			String contactUnit = request.getParameter("contactUnit");
			String type = request.getParameter("type");
			String num = request.getParameter("num");
			String stockDate = request.getParameter("stockDate");
			String batch = request.getParameter("batch");
			String order = request.getParameter("order");
			String userId = request.getParameter("userId");
			MultipartHttpServletRequest multiRequest=(MultipartHttpServletRequest)request;
	        
	        
			stock stocks = new stock();
			Date time=null;
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
			if(null!=contactUnit&&!(StringUtils.isEmpty(contactUnit)))
				stocks.setContactUnit(contactUnit);
			if(null!=type&&!(StringUtils.isEmpty(type)))
				stocks.setType(Integer.parseInt(type));
			if(null!=num&&!(StringUtils.isEmpty(num)))
				stocks.setNum(Integer.parseInt(num));
			if(null!=stockDate&&!(StringUtils.isEmpty(stockDate)))
				try {
					time=sdf.parse(stockDate);
				} catch (ParseException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
				stocks.setStockDate(time);
			if(null!=batch&&!(StringUtils.isEmpty(batch)))
				stocks.setBatch(Integer.parseInt(batch));
			if(null!=order&&!(StringUtils.isEmpty(order)))
				stocks.setOrders(Integer.parseInt(order));
			if(null!=userId&&!(StringUtils.isEmpty(batch)))
				stocks.setUserId(Integer.parseInt(userId));
			try {
				
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			stockService.save(stocks);
		return "listAllStock";
	}
	
	
	//根据id获取对象
	/**
	 * 获取对象
	 */
	@RequestMapping("/findStockByID")
	public void findStockByID(HttpServletRequest request,HttpServletResponse response){
		String id = request.getParameter("id");
		PrintWriter out =null;
		if(null!=id&&!(StringUtils.isEmpty(id))){
			stock stocks = stockService.get(Integer.parseInt(id));
			JSONObject json =new JSONObject();
			json.put("stock",stocks);
			JSONArray f = JSONArray.fromObject(stocks);
			try {
				out = response.getWriter();
						out.print(f.get(0));
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally{
				if(null!=out)
					out.close();
			}
		}
	}
	
	//剪贴板
	
		@RequestMapping("/clipboard")
		@ResponseBody
	    public void setClipboard(HttpServletRequest request,HttpServletResponse response) {
			PrintWriter out = null;
			String isSuccess="";
			try{
	    	StringSelection stringSelection = new StringSelection(request.getParameter("text"));
			  Clipboard  clipboard = Toolkit.getDefaultToolkit().getSystemClipboard();
			  clipboard.setContents(stringSelection, null);
			  out = response.getWriter();
			  isSuccess="复制成功";
			}catch(Exception e){
				try {
					out= response.getWriter();
				} catch (IOException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				} 
				isSuccess="复制失败";
				e.printStackTrace();
			}finally{
				out.write(isSuccess);
				out.close();
			}
			  
			  
		} 
}

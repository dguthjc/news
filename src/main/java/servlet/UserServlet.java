package servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.IOUtils;

import service.UserService;
import tools.Message;
import tools.PageInformation;
import tools.SearchTool;
import tools.Tool;
import bean.News;
import bean.User;

public class UserServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String type=request.getParameter("type1");
		UserService userService=new UserService();
		Message message=new Message();
		if(type.equals("register")){
			// Create a factory for disk-based file items
			DiskFileItemFactory factory = new DiskFileItemFactory();
			// Configure a repository (to ensure a secure temp location is used)
			String fullPath=request.getServletContext().getRealPath("/temp");//获取相对路径的绝对路径
			File temp = new File(fullPath);
			factory.setRepository(temp);//设置临时文件存放的文件夹
			String value="";
			// Create a new file upload handler
			ServletFileUpload upload = new ServletFileUpload(factory);
			// 解析request，将其中各表单元素和上传文件提取出来
				List<FileItem> items=null;
				try {
					items = upload.parseRequest(request);
				} catch (FileUploadException e) {
					
					e.printStackTrace();
				}//items存放各表单元素
				User user=new User();
				Iterator<FileItem> iter = items.iterator();
				while (iter.hasNext()) {//遍历表单元素
				    FileItem item = iter.next();

				    if (item.isFormField()) {//非上传文件表单元素
				        String name = item.getFieldName();//获取表单元素的name属性
				        if("type".equals(name))
				        	user.setType(item.getString("UTF-8"));
				        if("name".equals(name))
				        	user.setName(item.getString("UTF-8"));
				        if("sex".equals(name))
				        	user.setSex(item.getString("UTF-8"));
				        if("password".equals(name))
				        	user.setPassword(item.getString("UTF-8"));
				        if("hobby".equals(name))
				        	user.setHobby(item.getString("UTF-8"));
				        
				    } else {//上传文件	
			    	    if("".equals(item.getName())){
				        	 user.setHeadimg("/news/imag/default.jpg");
				        }else{
					    	File uploadedFile = new File(request.getServletContext().getRealPath("/images/headImg/"+item.getName()));
					        try {
								item.write(uploadedFile);
							} catch (Exception e) {
								e.printStackTrace();
							}//将临时文件转存为新文件保存（有同名文件，将被覆盖）
					        item.delete();//删除临时文件
					        //String path = this.getServletContext().getRealPath("/images/headImg");
					        user.setHeadimg("/news/images/headImg/"+item.getName());
				        }
				    }			    
				 }
			if(user.getType().equals("manager") || user.getType().equals("newsAuthor")){
				user.setSex(null);
				user.setHobby(null);
			}
					
			if(user.getType().equals("user"))
				user.setEnable("use");
			else
				user.setEnable("stop");			
			
			int result=userService.register(user);
			message.setResult(result);
			if(result==1){
				message.setMessage("注册成功！");
				message.setRedirectUrl("/news/user/login.jsp");
			}else if(result==0){
				message.setMessage("同名用户已存在，请改名重新注册！");
				message.setRedirectUrl("/news/user/register.jsp");
			}else{
				message.setMessage("注册失败！");
				message.setRedirectUrl("/news/user/register.jsp");
			}
			request.setAttribute("message", message);
			RequestDispatcher rd = request.getRequestDispatcher("/message.jsp");
			try {
				rd.forward(request, response);  
				return;
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
			//getServletContext().getRequestDispatcher("/message.jsp").forward(request,response);
		}else if(type.equals("login")){
			String loginInfo="";
			String checkcode=request.getParameter("checkcode");
			if(checkcode.equals(request.getSession().getAttribute("checkcode_session"))==false){
				loginInfo="验证码错误！";
			}
			else{
				User user=new User();
				user.setName(request.getParameter("name"));
				user.setPassword(request.getParameter("password"));
				int result=userService.login(user);
				message.setResult(result);
				if(result==1){
					request.getSession().setAttribute("user", user);
					/*String url = (String)request.getSession().getAttribute("originalUrl");
					if(url==null){*/
						response.sendRedirect("/news/index");
						return;
					/*}else{
						response.sendRedirect(url);
						return;
					}*/
				}else if(result==0){
					loginInfo="用户存在，但已被停用，请联系管理员！";
				}else if(result==-1){
					loginInfo="用户不存在，或者密码错误！";
				}
			}
			request.setAttribute("loginInfo", loginInfo);
			RequestDispatcher rd = request.getRequestDispatcher("/user/login.jsp");
			try {
				rd.forward(request, response);  
				return;
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
			
		}else if(type.equals("managerLogin")){
			String loginInfo="";
			User user=new User();
			user.setName(request.getParameter("name"));
			user.setPassword(request.getParameter("password"));
			int result=userService.managerLogin(user);
			message.setResult(result);
			if(result==1){
				request.getSession().setAttribute("user", user);
				response.sendRedirect("/news/manager/index.jsp");
				return;
			}else if(result==0){
				loginInfo="用户存在，但已被停用，请联系超级管理员！";
			}else if(result==-1){
				loginInfo="用户不存在，或者密码错误！";
			}else if(result==2){
				loginInfo="账号权限无法登陆！";
			}
			request.setAttribute("loginInfo", loginInfo);
			RequestDispatcher rd = request.getRequestDispatcher("/managerLogin.jsp");
			try {
				rd.forward(request, response);  
				return;
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
		}else if(type.equals("newsAuthorLogin")){
			String loginInfo="";
			User user=new User();
			user.setName(request.getParameter("name"));
			user.setPassword(request.getParameter("password"));
			int result=userService.newsAuthorLogin(user);
			message.setResult(result);
			if(result==1){
				request.getSession().setAttribute("user", user);
				response.sendRedirect("/news/newsManager/index.jsp");
				return;
			}else if(result==0){
				loginInfo="用户存在，但已被停用，请联系管理员！";
			}else if(result==-1){
				loginInfo="用户不存在，或者密码错误！";
			}else if(result==2){
				loginInfo="账号权限无法登陆！";
			}
			request.setAttribute("loginInfo", loginInfo);
			RequestDispatcher rd = request.getRequestDispatcher("/newsAuthorLogin.jsp");
			try {
				rd.forward(request, response);  
				return;
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
		}else if("exit".equals(type)){
			request.getSession().removeAttribute("user");
			RequestDispatcher rd = request.getRequestDispatcher("/index");
			try {
				rd.forward(request, response);  
				return;
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
		}else if(type.equals("modifyUserInfo")){
			User user = new User();
			try {
				//创建磁盘文件项工厂
				DiskFileItemFactory factory = new DiskFileItemFactory();
				//创建文件上传核心对象
				ServletFileUpload upload = new ServletFileUpload(factory);
				//解析request获得文件项对象集合

				List<FileItem> parseRequest = upload.parseRequest(request);
				for(FileItem item : parseRequest){
					//判断是否是普通表单项
					boolean formField = item.isFormField();
					if(formField){
						//普通表单项 获得表单的数据 封装到Product实体中
						String fieldName = item.getFieldName();
						String fieldValue = item.getString("UTF-8");
						if("sex".equals(fieldName)) user.setSex(fieldValue);
						else if("hobby".equals(fieldName))  user.setHobby(fieldValue);
						
					}else{
						//文件上传项 获得文件名称 获得文件的内容
						String fileName = item.getName();
						if(fileName!=null && !"".equals(fileName)){
							String path = this.getServletContext().getRealPath("images/headImg");
							InputStream in = item.getInputStream();
							OutputStream out = new FileOutputStream(path+"/"+fileName);
							IOUtils.copy(in, out);
							in.close();
							out.close();
							item.delete();
							user.setHeadimg("/news/images/headImg/"+fileName);
						}else{
							user.setHeadimg("");
						}
					}
					
				}
				User u = (User) request.getSession().getAttribute("user");
				user.setUserId(u.getUserId());
				userService.modifyDetails(user);
				u.setHeadimg(user.getHeadimg());
				u.setHobby(user.getHobby());
				u.setSex(user.getSex());
				request.getSession().setAttribute("user", u);
				response.sendRedirect(request.getContextPath()+"/index");
				return;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if("modifyPwd".equals(type)){
			String pwd = request.getParameter("newPassword");
			User user = new User();
			User u = (User) request.getSession().getAttribute("user");
			user.setPassword(pwd);
			user.setUserId(u.getUserId());
			try {
				userService.modifyPwd(user);
			} catch (Exception e) {
				e.printStackTrace();
			}
			u.setPassword(pwd);
			String loginInfo = "密码已修改，请重新登录";
			request.getSession().setAttribute("loginInfo", loginInfo);
			request.getSession().setAttribute("user", u);
			request.getRequestDispatcher("/user/login.jsp").forward(request, response);
			return;
		}
	}
	

}

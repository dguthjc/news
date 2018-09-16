package servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.IOUtils;

import service.UserService;
import tools.MailUtils;
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
		if(type.equals("register")){
			String loginInfo="";
			
			DiskFileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
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
				        if("checkcode".equals(name)){//检查验证码
				        	if(item.getString("UTF-8").equals(request.getSession().getAttribute("checkcode_session"))==false){
								loginInfo="验证码错误！";
								request.setAttribute("loginInfo", loginInfo);
								request.getRequestDispatcher("/user/register.jsp").forward(request, response);
								return;
							}
				        }
				        if("type".equals(name))
				        	user.setType(item.getString("UTF-8"));
				        if("name".equals(name))
				        	user.setName(item.getString("UTF-8"));
				        if("sex".equals(name))
				        	user.setSex(item.getString("UTF-8"));
				        if("password".equals(name)){
				        	String str=item.getString("UTF-8");
				        	Base64 base64=new Base64();
				    		byte[] encode = base64.encode(str.getBytes());
				    		String tempPwd = new String(encode);
				        	user.setPassword(tempPwd);
				        }
				        if("hobby".equals(name))
				        	user.setHobby(item.getString("UTF-8"));
				        if("email".equals(name))
				        	user.setEmail(item.getString("UTF-8"));
				        
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
					        //item.delete();//删除临时文件
					        //String path = this.getServletContext().getRealPath("/images/headImg");
					        user.setHeadimg("/news/images/headImg/"+item.getName());
				        }
				    }			    
				 }
			if(user.getType().equals("manager") || user.getType().equals("newsAuthor")){
				user.setSex(null);
				user.setHobby(null);
			}
					
			user.setEnable("stop");	
			String email_code=UUID.randomUUID().toString();
			user.setRegister_code(email_code);
			
			int result=userService.register(user);
			if(result==1){
				try {
					String emailMsg = "请点击下方链接完成账号激活<br>"
							+ "<a href='http://localhost:8080/news/servlet/UserServlet?type1=changeRegisterCode&register_code="+email_code+"'>"
							+ "http://localhost:8080/news/servlet/UserServlet?type1=changeRegisterCode&register_code="+email_code+"</a>";
					MailUtils.sendMail(user.getEmail(), emailMsg);
					response.sendRedirect(request.getContextPath()+"/registerSuccess.jsp");
				} catch (AddressException e) {
					e.printStackTrace();
				} catch (MessagingException e) {
					e.printStackTrace();
				}
				//message.setRedirectUrl("/news/user/login.jsp");
			}else if(result==2){
				loginInfo="同名用户已存在，请修改用户名重新注册！";
				request.setAttribute("loginInfo", loginInfo);
				request.getRequestDispatcher("/user/register.jsp").forward(request, response);
				return;
			}else if(result==3){
				loginInfo="邮箱已被注册，请更改邮箱重新注册！";
				request.setAttribute("loginInfo", loginInfo);
				request.getRequestDispatcher("/user/register.jsp").forward(request, response);
				return;
			}else{
				loginInfo="注册失败！请联系管理员！";
				request.setAttribute("loginInfo", loginInfo);
				request.getRequestDispatcher("/user/register.jsp").forward(request, response);
				return;
			}
			
			
			//getServletContext().getRequestDispatcher("/message.jsp").forward(request,response);
		}else if("changeRegisterCode".equals(type)){
			String register_code = request.getParameter("register_code");
			try {
				userService.changeRegisterCode(register_code);
			} catch (Exception e) {
				e.printStackTrace();
			}
			String loginInfo="激活成功，请登录！";
			request.setAttribute("loginInfo", loginInfo);
			request.getRequestDispatcher("/user/login.jsp").forward(request, response);
			return ;
		}else if(type.equals("login")){
			String loginInfo="";
			String checkcode=request.getParameter("checkcode");
			if(checkcode.equals(request.getSession().getAttribute("checkcode_session"))==false){
				loginInfo="验证码错误！";
			}else{
				User user=new User();
				user.setName(request.getParameter("name"));
				String tempPwd=request.getParameter("password");
				String pwd = "";
				try {
					pwd = userService.getPwdByName(request.getParameter("name"));
					if("".equals(pwd)){
						loginInfo="账户不存在！";
					}else if(!"".equals(pwd)){
						Base64 base64=new Base64();
						String str = new String(pwd);
						byte[] decode = base64.decode(str.getBytes());
						String password = new String(decode);
						if(!tempPwd.equals(password)){
							loginInfo="密码错误！";
						}else{
							user.setPassword(pwd);
							int result=userService.login(user);
							if(result==1){
								user.setPassword(password);
								request.getSession().setAttribute("user", user);
								response.sendRedirect(request.getContextPath()+"/index");
								return;
							}else if(result==0){
								loginInfo="该账户已被停用或未激活！";
							}
						}
					}
				} catch (Exception e) {
					e.printStackTrace();
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
		}else if("modifyPwdCheck".equals(type)){
			User user = (User) request.getSession().getAttribute("user");
			try {
				String emailMsg = "请点击下方链接获取密码修改权限<br>"
						+ "<a href='http://localhost:8080/news/user/modifyPwd.jsp'>"
						+ "请点击此处获取</a>";
				MailUtils.sendMail(user.getEmail(), emailMsg);
				response.sendRedirect(request.getContextPath()+"/modifyCheckSuccess.jsp");
			} catch (AddressException e) {
				e.printStackTrace();
			} catch (MessagingException e) {
				e.printStackTrace();
			}
		}else if("modifyPwd".equals(type)){
			String pwd = request.getParameter("newPassword");
			User user = new User();
			User u = (User) request.getSession().getAttribute("user");
			Base64 base64=new Base64();
    		byte[] encode = base64.encode(pwd.getBytes());
    		String tempPwd = new String(encode);
        	user.setPassword(tempPwd);
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

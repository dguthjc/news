package servlet;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import bean.News;
import bean.User;
import service.NewsService;
import tools.Message;
import tools.PageInformation;
import tools.SearchTool;
import tools.Tool;

public class NewsServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String type=request.getParameter("type1");
		NewsService newsService=new NewsService();
		Message message=new Message();
		if("addNews".equals(type)){
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
			try {
				List<FileItem> items = upload.parseRequest(request);//items存放各表单元素
				News news=new News();
				Iterator<FileItem> iter = items.iterator();
				while (iter.hasNext()) {//遍历表单元素
				    FileItem item = iter.next();
			        String name = item.getFieldName();//获取表单元素的name属性
			        if("title".equals(name))
			        	news.setTitle(item.getString("UTF-8"));
			        else if("type".equals(name))
			        	news.setType(item.getString("UTF-8"));
			        else if("editorValue".equals(name)){//uedit上传的内容的数据名称是：editorValue
			        	news.setContent(item.getString("UTF-8"));
				 }
				}
				
				User user = new User();
				user = (User) request.getSession().getAttribute("user");
				news.setAuthor(user.getName());
				news.setCommentnumber(0);
				news.setStatus("refuse");	
				int result=newsService.addNews(news);
				message.setResult(result);
				if(result==1){
					message.setMessage("新闻提交成功成功！请等待管理员审核.....");
					message.setRedirectUrl("/news/newsManager/addNews.jsp");
				}else if(result==0){
					message.setMessage("新闻标题已存在，请重新编辑！");
					message.setRedirectUrl("/news/newsManager/addNews.jsp");
				}else{
					message.setMessage("新闻提交失败！");
					message.setRedirectUrl("/news/newsManager/addNews.jsp");
				}
				request.setAttribute("message", message);
				RequestDispatcher rd = request.getRequestDispatcher("/message.jsp");
				try {
					rd.forward(request, response);  
					return;
				} catch (Exception e) {
					throw new RuntimeException(e);
				}
			}catch (Exception e) {
			}
		}else if("showMyNews".equals(type)){
			
		}else if("showAllNews".equals(type)){
			
			PageInformation pageInformation=new PageInformation();
			Tool.getPageInformation("news", request, pageInformation);
			pageInformation.setSearchSql(SearchTool.news(request));
			List<News> news=newsService.getOnePage(pageInformation);
			request.setAttribute("pageInformation", pageInformation);
			request.setAttribute("news", news);
			
			RequestDispatcher rd = request.getRequestDispatcher("/newsManager/showAllNews.jsp");
			try {
				rd.forward(request, response);  
				return;
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
			
		}else if("showPersonalNews".equals(type)){
			PageInformation pageInformation=new PageInformation();
			Tool.getPageInformation("news", request, pageInformation);
			pageInformation.setSearchSql(SearchTool.news(request));
			List<News> news=newsService.getOnePage(pageInformation);
			request.setAttribute("pageInformation", pageInformation);
			request.setAttribute("news", news);
			RequestDispatcher rd = request.getRequestDispatcher("/newsManager/showPersonalNews.jsp");
			try {
				rd.forward(request, response);  
				return;
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
			
		}else if("beforeModifyNews".equals(type)){
			PageInformation pageInformation=new PageInformation();
			Tool.getPageInformation("news", request, pageInformation);
			pageInformation.setSearchSql(SearchTool.newsDetails(request));
			News news=newsService.getOneNews(pageInformation);
			request.setAttribute("news", news);
			RequestDispatcher rd = request.getRequestDispatcher("/newsManager/modifyNews.jsp");
			try {
				rd.forward(request, response);  
				return;
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
			
		}else if("modifyMyNews".equals(type)){
			Integer newsId=Integer.valueOf(request.getParameter("newsId"));
			String newsType=null;
			String newsTitle=null;
			String newsContent=null;
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
			try {
				List<FileItem> items = upload.parseRequest(request);//items存放各表单元素
				Iterator<FileItem> iter = items.iterator();
				while (iter.hasNext()) {//遍历表单元素
				    FileItem item = iter.next();
			        String name = item.getFieldName();//获取表单元素的name属性
			        if("title".equals(name))
			        	newsTitle=item.getString("UTF-8");
			        else if("type".equals(name))
			        	newsType=item.getString("UTF-8");
			        else if("newsId".equals(name))
			        	newsId=Integer.valueOf(item.getString("UTF-8"));
			        else if("editorValue".equals(name)){//uedit上传的内容的数据名称是：editorValue
			        	newsContent=item.getString("UTF-8");
				 }
				}
			}catch (Exception e) {
			}
			boolean modifySuccess=newsService.modifyNews(newsId,newsType,newsTitle,newsContent);
			if(modifySuccess){
				message.setResult(1);
				message.setMessage("新闻修改成功！请等待管理员审核.....");
				message.setRedirectUrl("/news/newsServlet?type1=showPersonalNews&page=1&pageSize=4");
			}else{
				message.setResult(0);
				message.setMessage("新闻修改失败！请联系管理员.....");
				message.setRedirectUrl("/news/newsServlet?type1=showPersonalNews&page=1&pageSize=4");
			}
			request.setAttribute("message", message);
			RequestDispatcher rd = request.getRequestDispatcher("/message.jsp");
			try {
				rd.forward(request, response);  
				return;
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
			
			
		}else if("showPage".equals(type)){
			
			PageInformation pageInformation=new PageInformation();
			Tool.getPageInformation("news", request, pageInformation);
			List<News> news=newsService.getOnePage(pageInformation);
			request.setAttribute("pageInformation", pageInformation);
			request.setAttribute("news", news);
			
			RequestDispatcher rd = request.getRequestDispatcher("/newsManager/showAllNews.jsp");
			try {
				rd.forward(request, response);  
				return;
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
			
		}else if("showPersonalPage".equals(type)){
			
			PageInformation pageInformation=new PageInformation();
			Tool.getPageInformation("news", request, pageInformation);
			List<News> news=newsService.getOnePage(pageInformation);
			request.setAttribute("pageInformation", pageInformation);
			request.setAttribute("news", news);
			
			RequestDispatcher rd = request.getRequestDispatcher("/newsManager/showPersonalNews.jsp");
			try {
				rd.forward(request, response);  
				return;
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
			
		}else if("details".equals(type)){
			
			PageInformation pageInformation=new PageInformation();
			Tool.getPageInformation("news", request, pageInformation);
			pageInformation.setSearchSql(SearchTool.newsDetails(request));
			News news=newsService.getOneNews(pageInformation);
			request.setAttribute("news", news);
			System.out.println(news.getTitle());
			RequestDispatcher rd = request.getRequestDispatcher("/newsManager/newsDetails.jsp");
			try {
				rd.forward(request, response);  
				return;
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
			
		}/*else if(type.equals("checkNews")){
			PageInformation pageInformation=new PageInformation();
			Tool.getPageInformation("news", request, pageInformation);
			String id=pageInformation.getIds();
			pageInformation.setIds(null);
			List<News> news=newsService.checkNews(pageInformation, id);			
			if(news==null){
				message.setMessage("审核未通过！");
				message.setRedirectUrl("/news/newsServlet?type1=checkNews&page=1&pageSize=4");
			}else{
				request.setAttribute("pageInformation", pageInformation);
				request.setAttribute("news", news);
				
				RequestDispatcher rd = request.getRequestDispatcher("/manager/newsCheck.jsp");
				try {
					rd.forward(request, response);  
					return;
				} catch (Exception e) {
					throw new RuntimeException(e);
				}
				
			}
		}else if(type.equals("deleteNews")){
			PageInformation pageInformation=new PageInformation();
			Tool.getPageInformation("news", request, pageInformation);
			pageInformation.setSearchSql("");
			List<News> news=newsService.deleteNews(pageInformation);
			request.setAttribute("pageInformation", pageInformation);
			request.setAttribute("news", news);
			
			RequestDispatcher rd = request.getRequestDispatcher("/manager/newsDelete.jsp");
			try {
				rd.forward(request, response);  
				return;
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
		}*/
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
package servlet;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import bean.Comment;
import bean.News;
import bean.User;
import service.AdminService;
import service.UserService;
import tools.Message;
import tools.PageInformation;
import tools.SearchTool;
import tools.Tool;

public class AdminServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String type=request.getParameter("type1");
		AdminService adminService=new AdminService();
		Message message=new Message();
		if("showPage".equals(type)){
			PageInformation pageInformation=new PageInformation();
			Tool.getPageInformation("user", request, pageInformation);
			List<User> users=adminService.getOnePage(pageInformation);
			request.setAttribute("pageInformation", pageInformation);
			request.setAttribute("users", users);
			
			RequestDispatcher rd = request.getRequestDispatcher("/manager/user/userShow.jsp");
			try {
				rd.forward(request, response);  
				return;
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
		}else if("search".equals(type)){
			PageInformation pageInformation=new PageInformation();
			Tool.getPageInformation("user", request, pageInformation);
			pageInformation.setSearchSql(SearchTool.user(request));
			List<User> users=adminService.getOnePage(pageInformation);
			request.setAttribute("pageInformation", pageInformation);
			request.setAttribute("users", users);
			
			RequestDispatcher rd = request.getRequestDispatcher("/manager/user/userShow.jsp");
			try {
				rd.forward(request, response);  
				return;
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
			
			//getServletContext().getRequestDispatcher("/manager/userShow.jsp").forward(request,response);
		}else if("check".equals(type)){
			PageInformation pageInformation=new PageInformation();
			Tool.getPageInformation("user", request, pageInformation);
			String id=pageInformation.getIds();
			pageInformation.setIds(null);
			List<User> users=adminService.check(pageInformation, id);			
			if(users==null){
				message.setMessage("切换可用性失败，请联系管理员！");
				message.setRedirectUrl("/news/admin?type1=check&page=1&pageSize=17");
			}else{
				request.setAttribute("pageInformation", pageInformation);
				request.setAttribute("users", users);
				
				RequestDispatcher rd = request.getRequestDispatcher("/manager/user/userCheck.jsp");
				try {
					rd.forward(request, response);  
					return;
				} catch (Exception e) {
					throw new RuntimeException(e);
				}
				
				//getServletContext().getRequestDispatcher("/manager/userCheck.jsp").forward(request,response);
			}
		}else if("delete".equals(type)){
			PageInformation pageInformation=new PageInformation();
			Tool.getPageInformation("user", request, pageInformation);
			pageInformation.setSearchSql(" (type='user' or type='newsAuthor')");
			List<User> users=adminService.deletes(pageInformation);
			request.setAttribute("pageInformation", pageInformation);
			request.setAttribute("users", users);
			
			RequestDispatcher rd = request.getRequestDispatcher("/manager/user/userDelete.jsp");
			try {
				rd.forward(request, response);  
				return;
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
			
		}else if(type.equals("checkNews")){
			PageInformation pageInformation=new PageInformation();
			Tool.getPageInformation("news", request, pageInformation);
			String id=pageInformation.getIds();
			pageInformation.setIds(null);
			List<News> news=adminService.checkNews(pageInformation, id);			
			if(news==null){
				message.setMessage("审核未通过！");
				message.setRedirectUrl("/news/admin?type1=checkNews&page=1&pageSize=17");
			}else{
				request.setAttribute("pageInformation", pageInformation);
				request.setAttribute("news", news);
				
				RequestDispatcher rd = request.getRequestDispatcher("/manager/news/newsCheck.jsp");
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
			List<News> news=adminService.deleteNews(pageInformation);
			request.setAttribute("pageInformation", pageInformation);
			request.setAttribute("news", news);
			
			RequestDispatcher rd = request.getRequestDispatcher("/manager/news/newsDelete.jsp");
			try {
				rd.forward(request, response);  
				return;
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
		}else if("showAllNews".equals(type)){
			PageInformation pageInformation=new PageInformation();
			Tool.getPageInformation("news", request, pageInformation);
			pageInformation.setSearchSql(SearchTool.news(request));
			List<News> news=adminService.getOnePageNews(pageInformation);
			request.setAttribute("pageInformation", pageInformation);
			request.setAttribute("news", news);
			
			RequestDispatcher rd = request.getRequestDispatcher("/newsManager/showAllNews.jsp");
			try {
				rd.forward(request, response);  
				return;
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
			
		}else if("searchNewsWithoutContent".equals(type)){
			PageInformation pageInformation=new PageInformation();
			Tool.getPageInformation("news", request, pageInformation);
			pageInformation.setSearchSql(SearchTool.newsWithCommentToManager(request));
			List<News> news=adminService.getOnePageNews(pageInformation);
			request.setAttribute("pageInformation", pageInformation);
			request.setAttribute("news", news);
			
			RequestDispatcher rd = request.getRequestDispatcher("/manager/comment/showAllNews.jsp");
			try {
				rd.forward(request, response);  
				return;
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
			
		}else if("showPageInComment".equals(type)){
			
			PageInformation pageInformation=new PageInformation();
			Tool.getPageInformation("news", request, pageInformation);
			List<News> news=adminService.getOnePageNews(pageInformation);
			request.setAttribute("pageInformation", pageInformation);
			request.setAttribute("news", news);
			
			RequestDispatcher rd = request.getRequestDispatcher("/manager/comment/showAllNews.jsp");
			try {
				rd.forward(request, response);  
				return;
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
			
		}else if("findCommentByNewsId".equals(type)){
			String newsId=request.getParameter("newsId");
			List<Comment> comments = adminService.findOrderInfoByOid(newsId);
			Gson gson = new Gson();
			String json = gson.toJson(comments);
			response.getWriter().write(json);
		}else if("deleteComment".equals(type)){
			Integer newsId=Integer.valueOf(request.getParameter("newsId"));
			PageInformation CommentPageInformation=new PageInformation();
			PageInformation pageInformation=new PageInformation();
			Tool.getPageInformation("comment", request, CommentPageInformation);
			CommentPageInformation.setSearchSql("");
			Tool.getPageInformation("news", request, pageInformation);
			/*pageInformation.setSearchSql("");*/
			List<News> news=adminService.deleteComment(newsId,CommentPageInformation,pageInformation);
			request.setAttribute("pageInformation", pageInformation);
			request.setAttribute("news", news);
			
			RequestDispatcher rd = request.getRequestDispatcher("/manager/comment/showAllNews.jsp");
			try {
				rd.forward(request, response);  
				return;
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
		}else if("ajaxFindUserDetails".equals(type)){
			Integer userId=Integer.valueOf(request.getParameter("userId"));
			User user = adminService.ajaxFindUserDetails(userId);
			Gson gson = new Gson();
			String json = gson.toJson(user);
			response.getWriter().write(json);
		}
			
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
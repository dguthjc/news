package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import bean.Comment;
import bean.News;
import service.CommentService;
import service.NewsVisibleService;
import tools.Message;
import tools.PageInformation;
import tools.SearchTool;
import tools.Tool;

public class NewsVisibleServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String type=request.getParameter("type1");
		NewsVisibleService newsVisibleService=new NewsVisibleService();
		Message message=new Message();
		
		if("showNewsToAll".equals(type)){
			PageInformation pageInformation=new PageInformation();
			Tool.getPageInformation("news", request, pageInformation);
			pageInformation.setSearchSql(SearchTool.newsToUser(request));
			List<News> news=newsVisibleService.getOnePage(pageInformation);
			request.setAttribute("pageInformation", pageInformation);
			request.setAttribute("news", news);
			
			RequestDispatcher rd = request.getRequestDispatcher("/user/showNewsToAll.jsp");
			try {
				rd.forward(request, response);  
				return;
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
		}else if("showPage".equals(type)){
			
			PageInformation pageInformation=new PageInformation();
			Tool.getPageInformation("news", request, pageInformation);
			List<News> news=newsVisibleService.getOnePage(pageInformation);
			request.setAttribute("pageInformation", pageInformation);
			request.setAttribute("news", news);
			
			RequestDispatcher rd = request.getRequestDispatcher("/user/showNewsToAll.jsp");
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
			News news=newsVisibleService.getOneNews(pageInformation);
			request.setAttribute("news", news);
			request.setAttribute("update", request.getParameter("update"));
			
			Integer newsId=Integer.valueOf(request.getParameter("newsId"));
			CommentService commentService=new CommentService();
			List<Comment> comments=new ArrayList<Comment>();
			comments=commentService.seachAllComment(newsId);
			request.setAttribute("comments", comments);
			
			RequestDispatcher rd = request.getRequestDispatcher("/user/newsDetails.jsp");
			try {
				rd.forward(request, response);  
				return;
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
			
		}else if("seachNewsByWord".equals(type)){//根据标题模糊查询
			
			String word=request.getParameter("word");
			List<Object> titles=newsVisibleService.searchByWord(word);
			Gson gson = new Gson();
			String json = gson.toJson(titles);
			System.out.println(json);
			response.getWriter().write(json);
		}else if("searchBytitle".equals(type)){
			String title=request.getParameter("title");
			News news=newsVisibleService.searchBytitle(title);
			if(news.getNewsId()!=null){	
				request.setAttribute("news", news);
				RequestDispatcher rd = request.getRequestDispatcher("/user/newsDetails.jsp");
				try {
					rd.forward(request, response);  
					return;
				} catch (Exception e) {
					throw new RuntimeException(e);
				}
			}else{
				RequestDispatcher rd = request.getRequestDispatcher("/index");
				try {
					rd.forward(request, response);  
					return;
				} catch (Exception e) {
					throw new RuntimeException(e);
				}
			}
			
		}
		
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
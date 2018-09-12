package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.News;
import service.IndexService;

public class IndexServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<News> latestNews=new ArrayList<News>();
		List<News> hotNews=new ArrayList<News>();
		List<News> military=new ArrayList<News>();
		List<News> economics=new ArrayList<News>();
		List<News> sports=new ArrayList<News>();
		List<News> entertainment=new ArrayList<News>();
		List<News> guessYouLike=new ArrayList<News>();
		IndexService indexService=new IndexService();
		latestNews=indexService.latestNews();
		hotNews=indexService.hotNews();
		military=indexService.militaryNews();
		economics=indexService.economicsNews();
		sports=indexService.sportsNews();
		guessYouLike=indexService.guessYouLikeNews();
		entertainment=indexService.entertainmentNews();
		request.setAttribute("latestNews", latestNews);
		request.setAttribute("hotNews", hotNews);
		request.setAttribute("military", military);
		request.setAttribute("economics", economics);
		request.setAttribute("sports", sports);
		request.setAttribute("guessYouLike", guessYouLike);
		request.setAttribute("entertainment", entertainment);
		RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
		try {
			rd.forward(request, response);  
			return;
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
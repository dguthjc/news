package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Statistic;
import service.StatisticService;
import tools.Message;

public class StatisticsServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String type=request.getParameter("type1");
		StatisticService statisticService=new StatisticService();
		
		if("statisticsByDate".equals(type)){
			String date=request.getParameter("date");
			String role=request.getParameter("role");
			List<Statistic> statistics=statisticService.statisticsByDate(role,date);
			if(statistics!=null){
				request.setAttribute("statistics", statistics);
				RequestDispatcher rd = request.getRequestDispatcher("/manager/statistic/statisticByDate.jsp");
				try {
					rd.forward(request, response);  
					return;
				} catch (Exception e) {
					throw new RuntimeException(e);
				}
			}else{
				Message message=new Message();
				message.setResult(0);
				message.setMessage("统计失败！");
				message.setRedirectUrl("/news/manager/statisticsOption.jsp");
				request.setAttribute("message", message);
				RequestDispatcher rd = request.getRequestDispatcher("/message.jsp");
				try {
					rd.forward(request, response);  
					return;
				} catch (Exception e) {
					throw new RuntimeException(e);
				}
			}
		}else if("statisticsTotal".equals(type)){
			List<Statistic> statistics=statisticService.statisticsTotal();
			if(statistics!=null){
				request.setAttribute("statistics", statistics);
				RequestDispatcher rd = request.getRequestDispatcher("/manager/statistic/statisticTotal.jsp");
				try {
					rd.forward(request, response);  
					return;
				} catch (Exception e) {
					throw new RuntimeException(e);
				}
			}else{
				Message message=new Message();
				message.setResult(0);
				message.setMessage("统计失败！");
				message.setRedirectUrl("/news/manager/statistic/statisticsOption.jsp");
				request.setAttribute("message", message);
				RequestDispatcher rd = request.getRequestDispatcher("/message.jsp");
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
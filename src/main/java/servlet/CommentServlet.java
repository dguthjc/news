package servlet;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.beanutils.Converter;

import bean.Comment;
import bean.User;
import service.CommentService;
import tools.Message;

public class CommentServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String type=request.getParameter("type1");
		User user = (User) request.getSession().getAttribute("user");
		CommentService commentService=new CommentService();
		Message message = new Message();
		
		if("addComment".equals(type)){
			Integer newsId=Integer.valueOf(request.getParameter("newsId")) ;
			String content=request.getParameter("content");
			Comment comment=new Comment();
			Timestamp commentDate=new Timestamp(System.currentTimeMillis());
			comment.setNewsId(newsId);
			comment.setContent(content);
			comment.setUserName(user.getName());
			comment.setCommentData(commentDate);
			boolean result=commentService.addComment(comment);
			
			if(result){
				message.setRedirectUrl("/news/newsVisible?type1=details&newsId="+newsId);
				response.setHeader("refresh", "0;URL="+message.getRedirectUrl());
			}else{
				message.setMessage("评论失败！");
				message.setRedirectUrl("/news/newsVisible?type1=details&newsId="+newsId);
				request.setAttribute("message", message);
				RequestDispatcher rd = request.getRequestDispatcher("/message.jsp");
				try {
					rd.forward(request, response);  
					return;
				} catch (Exception e) {
					throw new RuntimeException(e);
				}
			}
		}else if("modifyComment".equals(type)){
			String content=request.getParameter("modifyContent");
			Integer commentId=Integer.valueOf(request.getParameter("commentId"));
			Integer newsId=Integer.valueOf(request.getParameter("newsId")) ;
			String commentDate1=request.getParameter("commentData");
			SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			Date commentDate2=null;
			try {
				commentDate2 = format.parse(commentDate1);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			Date currentDate = new Date();
			Long x=(currentDate.getTime()-commentDate2.getTime());
			x=x/(1000*60);
			if(x>5){
				message.setRedirectUrl("/news/newsVisible?type1=details&update=0&newsId="+newsId);
				response.setHeader("refresh", "0;URL="+message.getRedirectUrl());
			}else{
				Comment comment=new Comment();
				Timestamp commentDate=new Timestamp(System.currentTimeMillis());
				comment.setCommentId(commentId);
				comment.setNewsId(newsId);
				comment.setContent(content);
				comment.setUserName(user.getName());
				comment.setModifyAvalible("yes");
				comment.setCommentData(commentDate);
				boolean result=commentService.modifyComment(comment);
				if(result){
					message.setRedirectUrl("/news/newsVisible?type1=details&update=1&newsId="+newsId);
					response.setHeader("refresh", "0;URL="+message.getRedirectUrl());
				}
			}
		}
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
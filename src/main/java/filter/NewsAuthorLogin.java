package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.User;

public class NewsAuthorLogin  implements Filter{

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		HttpServletRequest newsId = req;
		HttpSession session = newsId.getSession();
		User user=new User();
		if (session.getAttribute("user") != null) {//检查是否登录	
			String requestURIName =req.getRequestURL().toString();
			user=(User) session.getAttribute("user");
			if("manager".equals(user.getType()) || "newsAuthor".equals(user.getType()))
				chain.doFilter(request, response);	//传给下个filter处理		
		} else {//没登录
			RequestDispatcher rd = newsId.getRequestDispatcher("/newsAuthorLogin.jsp");
			try {
				rd.forward(request, response);  
				return;
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
		}
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
	}
	@Override
	public void destroy() {
	}

}

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

public class SecurityFilter implements Filter {

	public void destroy() {
		// TODO Auto-generated method stub

	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		HttpServletRequest newsId = req;
		HttpSession session = newsId.getSession();
		if (session.getAttribute("user") != null) {//检查是否登录			
			chain.doFilter(request, response);	//传给下个filter处理		
		} else {//没登录
			String originalUrl=newsId.getRequestURI();//获取用户请求的原始网址
			String content=newsId.getQueryString();
			originalUrl+="?"+content;
			System.out.println(content);
			newsId.getSession().setAttribute("originalUrl", originalUrl);//保存原始网址到session
			
			String aa=(String)newsId.getSession().getAttribute("originalUrl");
			
			/*res.sendRedirect("/news/user/login.jsp");//跳转到登录网页，至此中断了过滤链
*/			
			RequestDispatcher rd = newsId.getRequestDispatcher("/user/login.jsp");
			try {
				rd.forward(request, response);  
				return;
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
		}
	}

	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub

	}

}

package Fillter;

import java.io.IOException;

import Model.User;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet Filter implementation class Auth
 */
@WebFilter(filterName = "Filter2_auth-filter", urlPatterns = { "/login", "/pages/login.jsp", "/register",
		"/pages/registration.jsp" })
public class Filter2_Auth extends HttpFilter implements Filter {

	/**
	 * 
	 */
	private static final long serialVersionUID = -9085170415815212141L;

	/**
	 * @see HttpFilter#HttpFilter()
	 */
	public Filter2_Auth() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		// place your code here
	
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpSession session = httpRequest.getSession();
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		User user = (User) session.getAttribute("user");
		if (user != null) {
			httpResponse.sendRedirect("home");

		}
		// pass the request along the filter chain
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}

package Fillter;

import jakarta.servlet.Filter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import Model.User;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;

/**
 * Servlet Filter implementation class AuthAuthorization
 */
@WebFilter(filterName = "Filter2_auth-authorization", urlPatterns = {"/admin/*", "/pages/admin_user.jsp", "/pages/admin_product.jsp"})
public class Filter2_AuthAuthorization extends HttpFilter implements Filter {
       
    /**
	 * 
	 */
	private static final long serialVersionUID = 7894184097556549102L;

	/**
     * @see HttpFilter#HttpFilter()
     */
    public Filter2_AuthAuthorization() {
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
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		// place your code here
		
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		HttpSession session = httpRequest.getSession();
		User user = (User) session.getAttribute("user");
		
		if (user.getRoles() == 1) {
			httpResponse.sendError(HttpServletResponse.SC_NOT_FOUND);
			System.out.println("Filter2_auth-authorization: Lỗi user có roles=1");
			return;
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




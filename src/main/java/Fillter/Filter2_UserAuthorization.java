package Fillter;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

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
 * Servlet Filter implementation class UserAuthorization
 */
@WebFilter(filterName = "Filter2_user-authorization", urlPatterns = {"/*"})
public class Filter2_UserAuthorization extends HttpFilter implements Filter {
      
	/**
	 * 
	 */
	private static final long serialVersionUID = 4404022966538670549L;
	private static final List<String> EXCLUDED_URLS = Arrays.asList(
	        "/admin",
	        "/pages/admin_user.jsp",
	        "/pages/admin_product.jsp",
	        "/logout",
	        "/assets"
	    );
    /**
     * @see HttpFilter#HttpFilter()
     */
    public Filter2_UserAuthorization() {
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
		
		// Kiểm tra URL trước khi tiếp tục chuỗi filter
		String contextPath = ((HttpServletRequest) request).getContextPath();
		String requestURI = ((HttpServletRequest) request).getRequestURI();
		String servletPath = requestURI.substring(contextPath.length());
        
		if (user != null && user.getRoles() == 0 && !shouldExcludeUrl(servletPath)) {
			httpResponse.sendError(HttpServletResponse.SC_NOT_FOUND);
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
	
	private boolean shouldExcludeUrl(String requestURI) {
        // Kiểm tra xem URL có khớp với bất kỳ mẫu nào trong danh sách không
		
        return EXCLUDED_URLS.stream().anyMatch(requestURI::startsWith);
    }

}

package Fillter;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.Arrays;
import java.util.Map;

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
 * Servlet Filter implementation class CommentFilter
 */
@WebFilter(filterName = "authentication-filter", urlPatterns = { "/comments/*", "/admin/*", "/cart/*", "/pages/cart.jsp" })
public class Authentication extends HttpFilter implements Filter {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpFilter#HttpFilter()
	 */
	public Authentication() {
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
	@SuppressWarnings("unchecked")
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpSession session = httpRequest.getSession();
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		User user = (User) session.getAttribute("user");
		if(user == null) {
			
			Map<String, String[]> formData = httpRequest.getParameterMap();
			String originalUri = httpRequest.getRequestURI();
			String method = httpRequest.getMethod().toLowerCase();
			String loginLink = httpRequest.getContextPath() + "/login";
			StringBuffer data = new StringBuffer(
					"<input type='hidden' name='originalUri' value='" + originalUri + "'>"+
					"<input type='hidden' name='method' value='" + method + "'>"
					);
			
			formData.forEach((key, value) -> {
				Arrays.asList(value).forEach(v -> {
					data.append("<input type='hidden' name='" + key + "' value='" + v + "'>");
				});
			});


			httpResponse.getWriter()
						.write("<html><body>" + "<form id='redirectForm' action='" +loginLink + "' method='post'>"
								+ data + "</form>" + "<script>document.getElementById('redirectForm').submit();</script>"
								+ "</body></html>");
			return;
		}
			chain.doFilter(request, response);
		
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
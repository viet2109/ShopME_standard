package Fillter;

import java.io.IOException;

import Model.Cart;
import Utils.MathUtils;
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
 * Servlet Filter implementation class PaymentDAO
 */
@WebFilter(filterName = "Filter2_payment-fillter", urlPatterns = { "/checkout", "/pages/checkout.jsp", "/payment" })
public class Filter2_Payment extends HttpFilter implements Filter {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6349908912769557979L;

	/**
	 * @see HttpFilter#HttpFilter()
	 */
	public Filter2_Payment() {
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
		
		HttpSession session = ((HttpServletRequest) request).getSession();

		Cart sesCart = (Cart) session.getAttribute("cart");
		boolean checkCart = MathUtils.totalPriceCart(sesCart) > 0;
		if (!checkCart) {
			((HttpServletResponse) response).sendError(HttpServletResponse.SC_NOT_FOUND);
		} else {

			// pass the request along the filter chain
			chain.doFilter(request, response);
		}

	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}

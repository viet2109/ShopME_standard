package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;

import Fillter.ProductFilter;
import Utils.MathUtils;

/**
 * Servlet implementation class Shop
 */
@WebServlet("/products")
public class Shop extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Shop() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		request.setAttribute("page",
				request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page")));
		if (request.getParameter("id") != null) {
			
			request.getRequestDispatcher("/pages/shopDetail.jsp").forward(request, response);
			return;
		}

		// filter product
		String[] star = request.getParameterValues("star");
		String price = request.getParameter("price");

		ProductFilter filter = new ProductFilter();
		if (star != null) {
			filter.setStar(star);
		}
		if (price != null) {
			String[] price_r = price.split("-");
			if (!MathUtils.isNumber(price_r[1]))
				price_r[1] = String.valueOf(Integer.MAX_VALUE);
			filter.setPrice(price_r);
		}

		request.setAttribute("filter", filter);

		request.getRequestDispatcher("/pages/shop.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

package Controller;

import java.io.IOException;

import DAO.CartDAO;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class Cart
 */
@WebServlet("/cart")
public class Cart extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Cart() {
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
		request.getRequestDispatcher("/pages/cart.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		// insert product
		if (request.getParameter("action").equalsIgnoreCase("insert")) {
			int product_quantity = Integer.valueOf(request.getParameter("product-quantity"));
			int product_id = Integer.valueOf(request.getParameter("product-id"));

			int product_selected = request.getParameter("product-selected") != null
					? Integer.valueOf(request.getParameter("product-selected"))
					: 0;
			HttpSession session = request.getSession();
			Model.Cart cart = (Model.Cart) session.getAttribute("cart");
			User user = (User) session.getAttribute("user");

			boolean isExistProduct = cart.getProduct_quantity().keySet().stream()
					.anyMatch(p -> p.getId() == product_id);
			boolean isSuccess = true;
			// check if insert new product
			if (isExistProduct) {
				isSuccess = CartDAO.updateQuantityandSelected(cart.getId(), product_id, product_selected,
						product_quantity);
			} else {
				isSuccess = CartDAO.addProduct(cart.getId(), product_id, product_quantity);
			}
			if (isSuccess) {
				refreshCart(session, cart, user.getId());
			}
			// Lấy URL trước đó (referer)
			String referer = request.getHeader("referer");

			// Kiểm tra nếu referer không rỗng và nếu cần thực hiện xử lý dựa trên referer
			if (referer != null && !referer.isEmpty()) {
				// quay trở lại trang trước khi logout

				response.sendRedirect(referer);

			}
		}

		// delete product
		if (request.getParameter("action").equalsIgnoreCase("delete")) {
			int product_id = Integer.valueOf(request.getParameter("product-id"));
			HttpSession session = request.getSession();
			Model.Cart cart = (Model.Cart) session.getAttribute("cart");
			User user = (User) session.getAttribute("user");
			boolean isSuccess = CartDAO.deleteProduct(cart.getId(), product_id);
			if (isSuccess) {
				refreshCart(session, cart, user.getId());
			}
			// Lấy URL trước đó (referer)
			String referer = request.getHeader("referer");

			// Kiểm tra nếu referer không rỗng và nếu cần thực hiện xử lý dựa trên referer
			if (referer != null && !referer.isEmpty()) {
				// quay trở lại trang trước khi logout

				response.sendRedirect(referer);

			}
		}
	}

	private void refreshCart(HttpSession session, Model.Cart cart, int user_id) {
		cart = CartDAO.getByUserId(user_id);
		session.setAttribute("cart", cart);
	}

}

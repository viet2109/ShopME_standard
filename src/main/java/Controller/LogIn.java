package Controller;

import java.io.IOException;
import java.util.Arrays;
import java.util.Map;

import DAO.CartDAO;
import DAO.UserDAO;
import Model.Cart;
import Model.User;
import Utils.BCrypt;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class Login
 */
@WebServlet("/login")
public class LogIn extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LogIn() {
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
		if (!response.isCommitted()) {
		    response.resetBuffer();
		    response.setContentType("text/html");
		    request.getRequestDispatcher("/pages/login.jsp").include(request, response);
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		HttpSession session = request.getSession();
		Map<String, String[]> paramaterMap = request.getParameterMap();
		String user_name_phone = request.getParameter("username");
		String password = request.getParameter("password");

		if (paramaterMap.isEmpty()) {
			return;
		} else {
			doGet(request, response);
			
		}

		User user = UserDAO.getByPhoneOrEmail(user_name_phone);

		if (user == null) {
			request.setAttribute("status", "failed");
			request.setAttribute("username", user_name_phone);
			request.setAttribute("password", password);
			doGet(request, response);
			
			return;

		}

		if (!login(user, password, user_name_phone, request, response, session)) {
			return;
		}

		if (request.getParameter("originalUri") != null) {
			String url = request.getParameter("originalUri");
			String method = request.getParameter("method");
			
			StringBuffer data = new StringBuffer();
			paramaterMap.forEach((key, value) -> {
				Arrays.asList(value).forEach(v -> {
					if (!(key.equals("username") || key.equals("password"))) {					
						data.append("<input type='hidden' name='" + key + "' value='" + v + "'>");
					}
					
				});
			});


			response.getWriter()
					.write("<html><body>" + "<form id='redirectForm' action='" + url + "' method='" + method + "'>"
							+ data + "</form>" + "<script>document.getElementById('redirectForm').submit();</script>"
							+ "</body></html>");
			return;
		}

		// get role to redirect
		if (user.getRoles() == 0) {
			// redirect admin page
			response.sendRedirect("admin/users?page=1");

		} else {

			response.sendRedirect("home");
		}

	}

	private boolean login(User user, String password, String user_name_phone, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {

		try {
			String hashPass = user.getPassword();

			if (!BCrypt.checkpw(password, hashPass)) {

				request.setAttribute("status", "failed");
				request.setAttribute("username", user_name_phone);
				request.setAttribute("password", password);
				doGet(request, response);
				return false;
			}

			Cart cart = CartDAO.getByUserId(user.getId());
			session.setAttribute("cart", cart);
			session.setAttribute("user", user);
		} catch (Exception e) {
			System.out.println(e);
		}
		return true;

	}

}
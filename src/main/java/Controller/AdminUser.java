package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.tomcat.util.json.JSONParser;

import DAO.OrderDAO;
import DAO.UserDAO;
import Model.Address;
import Model.Order;
import Model.User;
import Utils.BCrypt;

/**
 * Servlet implementation class Admin
 */
@WebServlet("/admin/users")
public class AdminUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AdminUser() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		LocalDate date = LocalDate.now();

		int page = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
		List<User> totalUser = UserDAO.getAll();
		List<User> result = UserDAO.getUsersByOffset(page);
		List<User> totalNewUser = UserDAO.getUsersByDateCurrent();
		double revenueOfMonth = OrderDAO.revenueOfMonth(date.getMonthValue(), date.getYear());
		double revenueOfQuarter = OrderDAO.revenueOfQuarter(((date.getMonthValue() - 1) / 3) + 1, date.getYear());

		request.setAttribute("page", page);
		request.setAttribute("totalUser", totalUser);
		request.setAttribute("result", result);
		request.setAttribute("totalNewUser", totalNewUser);
		request.setAttribute("revenueOfMonth", revenueOfMonth);
		request.setAttribute("revenueOfQuarter", revenueOfQuarter);
		request.getRequestDispatcher("/pages/admin_user.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String action = request.getParameter("action");
		int user_id = 0;
		String status = null;
		if (action == null) {
			BufferedReader reader = request.getReader();
			StringBuilder requestBody = new StringBuilder();
			String line;
			while ((line = reader.readLine()) != null) {
				requestBody.append(line);
			}
			Map<String, String> requestData = Utils.MathUtils.parseFormData(requestBody.toString());
			user_id = Integer.parseInt(requestData.get("customerId"));
			action = requestData.get("action");
		}

		if ("purchase_history".equals(action)) {
			List<Order> ordersOfUser = OrderDAO.getByUserId(user_id);

			request.setAttribute("ordersOfUser", ordersOfUser);
			// Build JSON manually
			StringBuilder jsonBuilder = Utils.MathUtils.ConvertOrderToJson(ordersOfUser);

			// Set response type to JSON
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");

			// Write JSON data to the response
			response.getWriter().write(jsonBuilder.toString());
			return;
		}
		if (action.equals("edit_user")) {
			user_id = Integer.parseInt(request.getParameter("user_id"));

			String firstName = request.getParameter("name").substring(request.getParameter("name").indexOf(" ") + 1);
			String lastName = request.getParameter("name").split(" ")[0];
			Date dob = Date.valueOf(request.getParameter("dob"));
			String email = request.getParameter("email");
			String phone = request.getParameter("phone");
			String country = request.getParameter("p_province");
			String city = request.getParameter("d_district");
			String ward = request.getParameter("w_ward");
			String detailAddress = request.getParameter("c_address");
			int role = Integer.parseInt(request.getParameter("role"));
			Address address = new Address(country, city, ward, detailAddress);
			User user = new User();
			user.setId(user_id);
			user.setFirstName(firstName);
			user.setLastName(lastName);
			user.setDob(dob);
			user.setEmail(email);
			user.setPhone(phone);
			user.setAddress(address);
			user.setRoles(role);
			
			boolean isSuccess = UserDAO.update(user);
			if (isSuccess)
				status = "update_success_user";
			else
				status = "update_failed_user";
			request.setAttribute("status", status);
			doGet(request, response);
			return;
		}
		if (action.equals("delete")) {
			user_id = Integer.parseInt(request.getParameter("user_id"));
			boolean isSuccess = UserDAO.delete(user_id);
			if (!isSuccess)
				request.setAttribute("status", "delete_failed");
			doGet(request, response);
			return;
		}

		if (action.equals("insert_user")) {
			String firstName = request.getParameter("firstName");
			String lastName = request.getParameter("lastName");
			String email = request.getParameter("email");
			String phone = request.getParameter("contact");
			Date date = Date.valueOf(request.getParameter("dob"));
			String user_pass = request.getParameter("pass");
			String user_re__pass = request.getParameter("re_pass");
			String password = BCrypt.hashpw(user_pass, BCrypt.gensalt());
			int roles = Integer.parseInt(request.getParameter("roles"));

			User user = new User(firstName, lastName, email, phone, date, password, roles);

			if (UserDAO.isExistEmail(email)) {
				request.setAttribute("status", "email_exist");
				request.setAttribute("firstName", firstName);
				request.setAttribute("lastName", lastName);
				request.setAttribute("email", email);
				request.setAttribute("phone", phone);
				request.setAttribute("date", date);
				request.setAttribute("pass", user_pass);
				request.setAttribute("re_pass", user_re__pass);
				request.setAttribute("roles", roles);
				doGet(request, response);
				return;
			}

			if (UserDAO.isExistPhone(phone)) {
				request.setAttribute("status", "phone_exist");
				request.setAttribute("firstName", firstName);
				request.setAttribute("lastName", lastName);
				request.setAttribute("email", email);
				request.setAttribute("phone", phone);
				request.setAttribute("date", date);
				request.setAttribute("pass", user_pass);
				request.setAttribute("re_pass", user_re__pass);
				request.setAttribute("roles", roles);
				doGet(request, response);
				return;
			}

			if (UserDAO.createNewUser(user)) {

				request.setAttribute("status", "success");
				doGet(request, response);
				return;

			} else {
				request.setAttribute("status", "failed");
				request.setAttribute("firstName", firstName);
				request.setAttribute("lastName", lastName);
				request.setAttribute("email", email);
				request.setAttribute("phone", phone);
				request.setAttribute("date", date);
				request.setAttribute("pass", user_pass);
				request.setAttribute("re_pass", user_re__pass);
				request.setAttribute("roles", roles);

			}
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

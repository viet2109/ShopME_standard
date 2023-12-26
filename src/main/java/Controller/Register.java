package Controller;

import java.io.IOException;
import java.sql.Date;

import DAO.UserDAO;
import Model.User;
import Utils.BCrypt;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class Register
 */
@WebServlet("/register")
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Register() {
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
		request.getRequestDispatcher("/pages/registration.jsp").forward(request, response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String email = request.getParameter("email");
		String phone = request.getParameter("contact");
		Date date = Date.valueOf( request.getParameter("dob"));
		String user_pass = request.getParameter("pass");
		String user_re__pass = request.getParameter("re_pass");
		String password = BCrypt.hashpw(user_pass, BCrypt.gensalt());

		User user = new User(firstName, lastName, email, phone, date, password, 1);
		
		if (UserDAO.isExistEmail(email)) {
			request.setAttribute("status", "email_exist");
			request.setAttribute("firstName", firstName);
			request.setAttribute("lastName", lastName);
			request.setAttribute("email", email);
			request.setAttribute("phone", phone);
			request.setAttribute("date", date);
			request.setAttribute("pass", user_pass);
			request.setAttribute("re_pass", user_re__pass);
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
			doGet(request, response);
			return;
		}
		

		if (UserDAO.createNewUser(user)) {

			HttpSession session = request.getSession();
			session.setAttribute("register_status", "success");
			response.sendRedirect("login");

		} else {
			request.setAttribute("status", "failed");
			request.setAttribute("firstName", firstName);
			request.setAttribute("lastName", lastName);
			request.setAttribute("email", email);
			request.setAttribute("phone", phone);
			request.setAttribute("date", date);
			request.setAttribute("pass", user_pass);
			request.setAttribute("re_pass", user_re__pass);

			doGet(request, response);
		}
	}

}

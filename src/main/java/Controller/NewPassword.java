package Controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import Database.DBConnection;
import Utils.BCrypt;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;



/**
 * Servlet implementation class NewPassword
 */
@WebServlet("/newPassword")
public class NewPassword extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		String newPassword = request.getParameter("password");
		String confPassword = request.getParameter("confPassword");
		RequestDispatcher dispatcher = null;
		if (newPassword != null && confPassword != null && newPassword.equals(confPassword)) {
			String hasPass = BCrypt.hashpw(confPassword, BCrypt.gensalt());
			try {
				
				
				PreparedStatement pst = DBConnection.connection.prepareStatement("update customers set passwd = ? where email = ? ");
				pst.setString(1, hasPass);
				pst.setString(2, (String) session.getAttribute("email"));

				int rowCount = pst.executeUpdate();
				if (rowCount > 0) {
					request.setAttribute("status", "resetSuccess");
					dispatcher = request.getRequestDispatcher("/pages/login.jsp");
				} else {
					request.setAttribute("status", "resetFailed");
					dispatcher = request.getRequestDispatcher("/pages/login.jsp");
				}
				dispatcher.forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

}

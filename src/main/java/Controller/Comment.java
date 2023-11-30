package Controller;

import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;

import Database.DBConnection;
import Model.User;
import Utils.CountRowSQL;

/**
 * Servlet implementation class Comment
 */
@WebServlet("/comments")
public class Comment extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Comment() {
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

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		String id = request.getParameter("product_id");

		String valueStar = request.getParameter("rating");
		String content = request.getParameter("content_comment");
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String date = LocalDateTime.now().format(formatter);
		try {

			PreparedStatement statement;
			String check_customer_id = "select id from customers where email=? or phone=?;";

			// Get customer_id
			statement = DBConnection.connection.prepareStatement(check_customer_id);
			statement.setString(1, user.getEmail());
			statement.setString(2, user.getPhone());
			ResultSet check_customer = statement.executeQuery();
			String customer_id = "";
			while (check_customer.next()) {
				customer_id = check_customer.getInt("id") + "";
			}
			
				// add comment
				String insert_comment = "insert into comment_tables (customer_id, product_id, content, create_date, rate) values (?,?,?,?,?);";
				statement = DBConnection.connection.prepareStatement(insert_comment);
				statement.setString(1, customer_id);
				statement.setString(2, id);
				statement.setString(3, content);
				statement.setString(4, date);
				statement.setString(5, valueStar);

				statement.executeUpdate();

				response.sendRedirect("products?id=" + id); // ng dung cmt thanh cong: true
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
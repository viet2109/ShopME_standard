package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.Iterator;
import java.util.Map;

import Database.DBConnection;
import Model.User;
import Utils.BCrypt;
import Utils.CountRowSQL;

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
		request.getRequestDispatcher("/pages/login.jsp").include(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(true);
		String user_name_phone = request.getParameter("username");
		String password = request.getParameter("password");
		String product_id = request.getParameter("product_id");
		String rating = request.getParameter("rating");
		String content_comment = request.getParameter("content_comment");
		int role = 0;
		
		request.setAttribute("rating",rating);
		request.setAttribute("product_id",product_id);
		request.setAttribute("content_comment",content_comment);
		
		
		if (user_name_phone == null || password == null) {
			return;
		}
		
		try {
			String sql = "select * from customers where email=? or phone=?";
			PreparedStatement statement = DBConnection.connection.prepareStatement(sql,ResultSet.TYPE_SCROLL_SENSITIVE, 
                    ResultSet.CONCUR_UPDATABLE);
			statement.setString(1, user_name_phone);
			statement.setString(2, user_name_phone);

			ResultSet result = statement.executeQuery();
			
			CountRowSQL countRow = new CountRowSQL(result);
			
			if (countRow.getRow() == 0) {
				
					request.setAttribute("status", "failed");
					request.setAttribute("username", user_name_phone);
					request.setAttribute("password", password);
					System.out.println("login fail");
					doGet(request, response);
					return;
				
			}
			if (!login(result, password, user_name_phone, request, response, session)) {
				return;
			};
			
			
			if(!product_id.isEmpty()) {
				response.sendRedirect("products?id="+product_id+"&rating="+rating+"&content_comment="+content_comment);
				return;
			}
			
			// get role to redirect
			
			while(result.next()) {
				role = result.getInt("roles");
				
				result.previous();
				break;
			}
			
			if (role==0) {
				// redirect admin page
				response.sendRedirect("admin/users?page=1");
				
			} else {
				
				response.sendRedirect("home");
			}
			
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}

	}
	private boolean login(ResultSet result, String password, String user_name_phone, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		
		try {
			String hashPass="";
			
			
			if(result.next()) {
				
				hashPass = result.getString("passwd");
				
				result.previous();
			}
		

		if (!BCrypt.checkpw(password, hashPass)) {
			
			request.setAttribute("status", "failed");
			request.setAttribute("username", user_name_phone);
			request.setAttribute("password", password);
			doGet(request, response);
			return false;
		}
		
		User user = null;
		
		while (result.next()) {

			user = new User(
					result.getInt("id"),
					result.getString("first_name"),
					result.getString("last_name"),
					result.getString("email"),
					result.getString("phone"),
					
					result.getDate("dob")
					);
			result.previous();
			break;

		}
		
		
	
		session.setAttribute("user", user);
		} catch (Exception e) {
			System.out.println(e);
		}
		return true;
		
	}

}
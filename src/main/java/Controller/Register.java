package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.Arrays;
import java.util.Calendar;

import java.util.Map;

import Database.DBConnection;
import Utils.BCrypt;
import Utils.CountRowSQL;

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
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.getRequestDispatcher("/pages/registration.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String email = request.getParameter("email");
		String phone = request.getParameter("contact");
		String date =  request.getParameter("dob");
		String user_pass = request.getParameter("pass");
		String user_re__pass = request.getParameter("re_pass");
		String password = BCrypt.hashpw(user_pass, BCrypt.gensalt());
		
		 
		
		try {
			
			PreparedStatement statement;
			
			String check_exist_user = "select * from customers where email=? or phone=?";
			
			statement = DBConnection.connection.prepareStatement(check_exist_user,ResultSet.TYPE_SCROLL_SENSITIVE, 
                    ResultSet.CONCUR_UPDATABLE);
			statement.setString(1, email);
			statement.setString(2, phone);
			
			
			ResultSet result = statement.executeQuery();
			CountRowSQL countRow = new CountRowSQL(result);
			
			if (countRow.getRow()>0) {
				result.next();
				
				if (result.getString("email").equals(email) && !result.getString("phone").equals(phone)) {
					request.setAttribute("status", "email_exist");
				} else if (!result.getString("email").equals(email) && result.getString("phone").equals(phone)) {
					
					request.setAttribute("status", "phone_exist");
				} else {
					request.setAttribute("status", "failed");
					
				}
				result.previous();
				
				System.out.println("user exist");
				
				request.setAttribute("firstName", firstName);
				request.setAttribute("lastName", lastName);
				request.setAttribute("email", email);
				request.setAttribute("phone", phone);
				request.setAttribute("date", date);
				request.setAttribute("pass", user_pass);
				request.setAttribute("re_pass", user_re__pass);
				doGet(request, response);
			}
			else {
				
				String register_sql = "insert into  customers (passwd, first_name, last_name,email, phone, dob, created_date)\r\n"
						+ "values (?,?,?,?,?,?,?);";
				
				
				statement = DBConnection.connection.prepareStatement(register_sql);
				
				statement.setString(1, password);
				statement.setString(2, firstName);
				statement.setString(3, lastName);
				statement.setString(4, email);
				statement.setString(5, phone);
				statement.setString(6, date);
				statement.setDate(7, Date.valueOf(LocalDate.now()));
				
				int update_success = statement.executeUpdate();
				
				if (update_success>0) {
					
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
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}

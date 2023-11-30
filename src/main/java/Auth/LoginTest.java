package Auth;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Login
 * @param <E>
 */

@WebServlet("/loginTest")
public class LoginTest<E> extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginTest() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/employee_directory", "root", "nhv21092003@");

			PreparedStatement statement = connect.prepareStatement("select * from employee");
			ResultSet res = statement.executeQuery();
			while (res.next()) {

				ResultSetMetaData rsmd = res.getMetaData();
				int columnCount = rsmd.getColumnCount();


				for (int i = 1; i <= columnCount; i++) {

					String columnName = rsmd.getColumnName(i);
					System.out.println(columnName + ": ");
					System.out.println(res.getString(columnName));
				}

			}
			request.getRequestDispatcher("/pages/index.jsp").forward(request, response);
			
		 	

		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("Connect db has problem");
			System.out.println(e);
		}
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setAttribute("status", "failed");
		
		request.getRequestDispatcher("/pages/registration.jsp").include(request, response);
	}

}


import java.sql.Date;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Enumeration;

import com.mysql.cj.jdbc.AbandonedConnectionCleanupThread;

import DAO.CartDAO;
import Database.DBConnection;
import Model.Cart;
import Model.User;
import Utils.CountRowSQL;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.ServletRequestEvent;
import jakarta.servlet.ServletRequestListener;
import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;

@WebListener
public class Application implements ServletContextListener, HttpSessionListener, ServletRequestListener {

	ServletRequestEvent request;

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		
		new DBConnection();
	}
	
	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		// TODO Auto-generated method stub

		Enumeration<Driver> drivers = DriverManager.getDrivers();
		Driver d = null;
		while (drivers.hasMoreElements()) {
			try {
				d = drivers.nextElement();
				DriverManager.deregisterDriver(d);

			} catch (SQLException ex) {

			}
		}
		AbandonedConnectionCleanupThread.checkedShutdown();
		
		
	}

	@Override
	public void requestInitialized(ServletRequestEvent sre) {
		// TODO Auto-generated method stub

		request = sre;
		
		
		ServletRequestListener.super.requestInitialized(sre);
	}

	@Override
	public void requestDestroyed(ServletRequestEvent sre) {
		// TODO Auto-generated method stub
		ServletRequestListener.super.requestDestroyed(sre);
	}

	@Override
	public void sessionCreated(HttpSessionEvent se) {
		// TODO Auto-generated method stub
		HttpSession session = se.getSession();

		User user = null;
		Cart cart = null;
		String ip = request.getServletRequest().getRemoteAddr();
		String sql;
		PreparedStatement statement;
		ResultSet result;

		try {
			sql = "select customers.* from user_re_login left join customers on user_re_login.id_user = customers.id where ip = ?";
			statement = DBConnection.connection.prepareStatement(sql);
			statement.setString(1, ip);
			result = statement.executeQuery();

			while (result.next()) {
				int id = result.getInt("id");
				String firstName = result.getString("first_name");
				String lastName = result.getString("last_name");
				String email = result.getString("email");
				String phone = result.getString("phone");
				Date dob = result.getDate("dob");
				String passwd = result.getString("passwd");
				int roles = result.getInt("roles");

				user = new User(id, firstName, lastName, email, phone, dob, passwd, roles);
				cart = CartDAO.getByUserId(id);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		session.setAttribute("ip", request.getServletRequest().getRemoteAddr());
		session.setAttribute("user", user);
		session.setAttribute("cart", cart);
		
		
		session.setAttribute("lang", "vi_VN");
		
		HttpSessionListener.super.sessionCreated(se);
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
		// TODO Auto-generated method stub

		HttpSession session = se.getSession();
		User user = (User) session.getAttribute("user");
		String sql;
		PreparedStatement statement;
		ResultSet result;
		int id;
		String ip = (String) session.getAttribute("ip");
		// save user
		if (user != null) {
			id = user.getId();
			try {
				
				// check if ip exist
				sql = "SELECT * FROM user_re_login WHERE ip=?";

				statement = DBConnection.connection.prepareStatement(sql,ResultSet.TYPE_SCROLL_SENSITIVE,
						ResultSet.CONCUR_UPDATABLE);
				statement.setString(1, ip);

				result = statement.executeQuery();
				CountRowSQL row = new CountRowSQL(result);
				if (row.getRow() > 0) {

					sql = "UPDATE user_re_login SET id_user = ? WHERE ip= ?";

					statement = DBConnection.connection.prepareStatement(sql);
					statement.setInt(1, id);
					statement.setString(2, ip);
					statement.executeUpdate();

				} else {

					sql = "INSERT INTO user_re_login VALUES (?, ?)";
					
					statement = DBConnection.connection.prepareStatement(sql);
					statement.setInt(1, id);
					statement.setString(2, ip);
					statement.executeUpdate();
					
					
				}
				
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			sql = "DELETE FROM user_re_login WHERE ip=?";
			try {
				statement = DBConnection.connection.prepareStatement(sql);
				statement.setString(1, ip);
				statement.executeUpdate();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		
		HttpSessionListener.super.sessionDestroyed(se);
	}

}

package DAO;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import Database.DBConnection;
import Model.User;
import Utils.CountRowSQL;
import Utils.DynamicPagination;

public class UserDAO {
	
	public static User getById(int userId) {
		User user = null;
		String sql = "SELECT * FROM customers WHERE id = ?";
		try {
			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			statement.setInt(1, userId);
			ResultSet result = statement.executeQuery();
			while (result.next()) {
				int id = result.getInt("id");
				String firstName = result.getString("first_name");
				String lastName = result.getString("last_name");
				String email = result.getString("email");
				String phone = result.getString("phone");
				Date dob = result.getDate("dob");
				int roles = result.getInt("roles");
				String password = result.getString("passwd");

				user = new User();
				user.setId(id);
				user.setEmail(email);
				user.setDob(dob);
				user.setPhone(phone);
				user.setFirstName(firstName);
				user.setLastName(lastName);
				user.setRoles(roles);
				user.setPassword(password);
			}
			statement.close();
			result.close();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return user;
	}

	public static User getByPhoneOrEmail(String phoneOrEmail) {
		User user = null;
		String sql = "SELECT * FROM customers WHERE phone = ? OR email = ?";
		try {
			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			statement.setString(1, phoneOrEmail);
			statement.setString(2, phoneOrEmail);
			ResultSet result = statement.executeQuery();
			while (result.next()) {
				int id = result.getInt("id");
				String firstName = result.getString("first_name");
				String lastName = result.getString("last_name");
				String email = result.getString("email");
				String phone = result.getString("phone");
				Date dob = result.getDate("dob");
				String password = result.getString("passwd");
				int roles = result.getInt("roles");

				user = new User();

				user.setId(id);
				user.setEmail(email);
				user.setDob(dob);
				user.setPhone(phone);
				user.setFirstName(firstName);
				user.setLastName(lastName);
				user.setPassword(password);
				user.setRoles(roles);
			}
			statement.close();
			result.close();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return user;
	}

	public static boolean createNewUser(User user) {
		

		String sql = "insert into customers(first_name, last_name, email, phone, dob, passwd, roles, created_date) values(?,?,?,?,?,?,?,?)";

		try {
			PreparedStatement statement = DBConnection.connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
			statement.setString(1, user.getFirstName());
			statement.setString(2, user.getLastName());
			statement.setString(3, user.getEmail());
			statement.setString(4, user.getPhone());
			statement.setDate(5, user.getDob());
			statement.setString(6, user.getPassword());
			statement.setInt(7, user.getRoles());
			statement.setDate(8, Date.valueOf(LocalDate.now()));
			
			
			int result = statement.executeUpdate();

			statement.close();
			if (result <= 0) {
				
				return false;
			}
			
			
			return true;

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}

	}

	public static boolean isExistEmail(String email) {
		String sql = "select * from customers where email = ?";

		try {
			PreparedStatement statement = DBConnection.connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
			statement.setString(1, email);
			
			ResultSet resultSet = statement.executeQuery();

			CountRowSQL count = new CountRowSQL(resultSet);

			if (count.getRow() > 0) {
				return true;
			}
			statement.close();
			resultSet.close();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
		return false;
	}
	
	public static boolean isExistPhone(String phone) {
		String sql = "select * from customers where phone = ?";

		try {
			PreparedStatement statement = DBConnection.connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
			statement.setString(1, phone);
			
			ResultSet resultSet = statement.executeQuery();

			CountRowSQL count = new CountRowSQL(resultSet);

			if (count.getRow() > 0) {
				return true;
			}
			statement.close();
			resultSet.close();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
		return false;
	}
	
	public static List<User> getAll() {
		List<User> list = new ArrayList<User>();
		String sql = "select * from cutomers";
		try {
			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			ResultSet rs = statement.executeQuery();
			
			while (rs.next()) {
				int id = rs.getInt("id");
				User user = getById(id);
				list.add(user);
			}
			statement.close();
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}
 	
	public static List<User> getUsersByOffset(int offset) {
		List<User> list = getAll();
		int beginIndex = (offset-1) * DynamicPagination.totalUserOfPage;
		int endIndex = beginIndex + DynamicPagination.totalUserOfPage;
		
		if (endIndex>list.size()) {
			endIndex = list.size();
		}
	
		return list.subList(beginIndex, endIndex);
	}


}

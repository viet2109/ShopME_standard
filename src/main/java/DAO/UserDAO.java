package DAO;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import Database.DBConnection;
import Model.Address;
import Model.Order;
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
				Date createDate = result.getDate("created_date");
				Address address = AddressDAO.getByUserId(userId);

				user = new User();
				user.setId(id);
				user.setEmail(email);
				user.setDob(dob);
				user.setPhone(phone);
				user.setFirstName(firstName);
				user.setLastName(lastName);
				user.setRoles(roles);
				user.setPassword(password);
				user.setCreateDate(createDate);
				user.setAddress(address);
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
		String sql = "select * from customers";
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
		int beginIndex = (offset - 1) * DynamicPagination.totalUserOfPage;
		int endIndex = beginIndex + DynamicPagination.totalUserOfPage;

		if (endIndex > list.size()) {
			endIndex = list.size();
		}

		return list.subList(beginIndex, endIndex);
	}

	public static boolean updateRole(int id, int roles) {
		String sql = "UPDATE customers SET roles = ? WHERE (id = ?);";
		try {
			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			statement.setInt(1, roles);
			statement.setInt(2, id);
			int result = statement.executeUpdate();
			if (result >= 0)
				return true;

			statement.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	public static boolean update(User user) {
		String sql = "UPDATE customers SET first_name=?, last_name=?, dob=?, email=?, phone=?, roles = ? WHERE id = ?;";
		try {
			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			statement.setString(1, user.getFirstName());
			statement.setString(2, user.getLastName());
			statement.setDate(3, user.getDob());
			statement.setString(4, user.getEmail());
			statement.setString(5, user.getPhone());
			statement.setInt(6, user.getRoles());
			statement.setInt(7, user.getId());
			int result = statement.executeUpdate();
			boolean isNewAddress = AddressDAO.addNewAddress(user.getAddress());
			int idAddress = AddressDAO.getIdByAddress(user.getAddress());
			user.getAddress().setId(idAddress);
			// Nếu đổi quyền từ admin thành user sẽ tìm kiếm address của user
			if (idAddress <= 0) {
				user.setAddress(AddressDAO.getByUserId(user.getId()));
				idAddress = user.getAddress().getId();
			}

			System.out.println("UserDAO: user.getAddress()=" + user.getAddress());
			// Them dia chi moi vao bang customer_addresses
			boolean isNewAddressOfCustomer = false;
			if (idAddress > 0)
				isNewAddressOfCustomer = AddressDAO.addNewUserAddress(user.getAddress(), user);
			// Cap nhat lai defaut cho cho cac dia chi cua mot user
			boolean isUpdateDefaut = false;
			if (user.getRoles() == 1)
				isUpdateDefaut = AddressDAO.updateDefautCustomerAddresses(user.getId(), idAddress);
			System.out.println("UserDAO: isNewAddress=" + isNewAddress + "; isNewAddressOfCustomer="
					+ isNewAddressOfCustomer + "; isUpdateDefaut=" + isUpdateDefaut + "; roles=" + user.getRoles());
			if (result == 1) {
				if ((isNewAddress && isNewAddressOfCustomer && isUpdateDefaut)
						|| (!isNewAddress && !isNewAddressOfCustomer && isUpdateDefaut)
						|| (!isNewAddress && isNewAddressOfCustomer && isUpdateDefaut) || (user.getRoles() == 0))
					return true;
			}

			statement.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	public static boolean delete(int id) {
		String sql = "DELETE FROM customers\r\n" + "    WHERE id = ? ;";
		try {
			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			statement.setInt(1, id);
			int result = statement.executeUpdate();
			statement.close();
			if (result >= 0)
				return true;

			statement.close();
		} catch (SQLException e) {
			if ("45000".equals(e.getSQLState())) {

				// Xử lý khi gặp lỗi "Cannot delete user with orders"

				return false;
			} else
				e.printStackTrace();
			return false;
		}
		return false;
	}

	// Danh sách khách hàng (roles=1)
	public static List<User> getUserListByRole(int roles) {
		List<User> list = new ArrayList<User>();
		String sql = "select * from customers where roles = ?";
		try {
			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			statement.setInt(1, roles);
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

	public static List<User> getUsersByDate(int month, int year) {
		List<User> users = new ArrayList<User>();
		String sql = "SELECT * FROM order_tables\r\n" + "where month(order_date)=? \r\n" + "and year(order_date)=?;";
		try {
			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			statement.setInt(1, month);
			statement.setInt(2, year);
			ResultSet result = statement.executeQuery();
			while (result.next()) {
				User user = UserDAO.getById(result.getInt("id"));
				users.add(user);
			}
			statement.close();
			result.close();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return users;
	}

	public static List<User> getUsersByDateCurrent() {
		LocalDate current = LocalDate.now();
		int month = current.getMonthValue();
		int year = current.getYear();
		return getUsersByDate(month, year);
	}

	public static User getReceiver(int orderId) {
		User receiver = new User();
		String sql = "SELECT * FROM order_receiver_infomation where order_id=?";
		try {
			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			statement.setInt(1, orderId);
			ResultSet result = statement.executeQuery();
			while (result.next()) {
				receiver.setFirstName(result.getString("first_name"));
				receiver.setLastName(result.getString("last_name"));
				receiver.setEmail(result.getString("email"));
				receiver.setPhone(result.getString("phone"));
			}
			statement.close();
			result.close();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return receiver;
	}

}

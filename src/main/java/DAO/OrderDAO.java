package DAO;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.oracle.wls.shaded.org.apache.xpath.operations.Or;

import Database.DBConnection;
import Model.Address;
import Model.Cart;
import Model.Coupon;
import Model.Order;
import Model.Payment;
import Model.Product;
import Model.User;
import Utils.DynamicPagination;

public class OrderDAO {

	/*
	 * Để thêm một order vào db 1) Thêm address vào address table(nếu address mới)
	 * 2) Thêm order
	 */
	public static boolean addOrder(Order order, int userId) {
		PreparedStatement statement;
		String sql;
		try {
			Cart cart = CartDAO.getByUserId(userId);
			AddressDAO.addNewAddress(order.getOrderAddress());

			int idAddress = AddressDAO.getIdByAddress(order.getOrderAddress());

			// add order_tables
			sql = "insert into order_tables (customer_id, address_id, order_date, coupon, payment_id, notes ) values(?,?,?,?,?,?)";
			statement = DBConnection.connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			statement.setInt(1, order.getSender().getId());
			statement.setInt(2, idAddress);
			statement.setDate(3, order.getOrderDate());
			statement.setString(4, order.getCoupon() != null ? order.getCoupon().getId() : null);
			statement.setInt(5, order.getPayment().getId());
			statement.setString(6, order.getNotes());
			int result = statement.executeUpdate();

			if (result > 0) {
				ResultSet rs = statement.getGeneratedKeys();
				rs.next();
				int orderId = rs.getInt(1);

				// add order_details and delete product in cart
				order.getProductAndQuantityList().forEach((product, quantity) -> {

					String sl;
					PreparedStatement st;
					try {
						sl = "insert into order_details values(?,?,?,?)";
						st = DBConnection.connection.prepareStatement(sl);
						st.setInt(1, orderId);
						st.setInt(2, product.getId());
						st.setInt(3, quantity);
						st.setDouble(4, product.getPrice()*product.getPercentSale());
						st.executeUpdate();

						CartDAO.deleteProduct(cart.getId(), product.getId());

						st.close();
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}

				});

				// add order_receiver_infomation
				sql = "insert into order_receiver_infomation values(?,?,?,?,?)";
				statement = DBConnection.connection.prepareStatement(sql);
				statement.setInt(1, orderId);
				statement.setString(2, order.getReceiver().getFirstName());
				statement.setString(3, order.getReceiver().getLastName());
				statement.setString(4, order.getReceiver().getEmail());
				statement.setString(5, order.getReceiver().getPhone());

				statement.executeUpdate();
				AddressDAO.addNewUserAddress(AddressDAO.getByid(idAddress), UserDAO.getById(userId));
			}
			
			statement.close();
			return result > 0;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	}
	

	public static List<Order> getAll() {
		List<Order> list = new ArrayList<Order>();
		String sql = "select * from order_tables";

		try {

			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			ResultSet result = statement.executeQuery();

			while (result.next()) {
				int id = result.getInt("id");
				Order order = getById(id);

				list.add(order);
			}

			statement.close();
			result.close();

		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}

		return list;
	}

	public static Order getById(int orderId) {
		Order order = new Order();
		Map<Product, Integer> productAndQuantityList = new HashMap<Product, Integer>();
		Map<Product, Double> productAndPrice = new HashMap<Product, Double>();
		String sql = "SELECT * \r\n" + "FROM order_tables \r\n" + "WHERE id = ?";
		try {
			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			statement.setInt(1, orderId);
			ResultSet result = statement.executeQuery();
			while (result.next()) {
				User sender = UserDAO.getById(result.getInt("customer_id"));// User is receiver
				Address address = AddressDAO.getByid(result.getInt("address_id"));
				Date orderDate = result.getDate("order_date");
				Coupon coupon = CouponDAO.getById(result.getString("coupon"));
				Payment payment = PaymentDAO.getById(result.getInt("payment_id"));
				productAndQuantityList = getProductListOrder(result.getInt("id"));
				String notes = result.getString("notes");
				productAndPrice = getProductListOrderPrice(result.getInt("id"));
				User receiver = UserDAO.getReceiver(orderId);

				order.setId(orderId);
				order.setSender(sender);
				order.setOrderAddress(address);
				order.setOrderDate(orderDate);
				order.setCoupon(coupon);
				order.setPayment(payment);
				order.setProductAndQuantityList(productAndQuantityList);
				order.setNotes(notes);
				order.setPrice(productAndPrice);
				order.setReceiver(receiver);
			}
			statement.close();
			result.close();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return order;
	}

	public static Map<Product, Integer> getProductListOrder(int orderId) {
		Map<Product, Integer> map = new HashMap<Product, Integer>();
		String sql = "SELECT * FROM order_details WHERE order_id = ?";
		try {
			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			statement.setInt(1, orderId);
			ResultSet result = statement.executeQuery();
			while (result.next()) {
				Product product = ProductDAO.getById(result.getInt("product_id"));
				int quantity = result.getInt("quantity");

				map.put(product, quantity);
			}
			statement.close();
			result.close();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return map;
	}
	
	public static Map<Product, Double> getProductListOrderPrice(int orderId) {
		Map<Product, Double> map = new HashMap<Product, Double>();
		String sql = "SELECT * FROM order_details WHERE order_id = ?";
		try {
			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			statement.setInt(1, orderId);
			ResultSet result = statement.executeQuery();
			while (result.next()) {
				Product product = ProductDAO.getById(result.getInt("product_id"));
				double saleprice = result.getFloat("saleprice");

				map.put(product, saleprice);
			}
			statement.close();
			result.close();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return map;
	}

	public static List<Order> getOrderByOffset(List<Order> list, int offset) {

		int beginIndex = (offset - 1) * DynamicPagination.totalOrderOfPage;
		int endIndex = beginIndex + DynamicPagination.totalOrderOfPage;

		if (endIndex > list.size()) {
			endIndex = list.size();
		}

		return list.subList(beginIndex, endIndex);
	}
	
	public static List<Order> getOrdersByDate(int month, int year){
		List<Order> orders = new ArrayList<Order>();
		String sql = "SELECT * FROM order_tables\r\n"
				+ "where month(order_date)=? \r\n"
				+ "and year(order_date)=?;";
		try {
			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			statement.setInt(1, month);
			statement.setInt(2, year);
			ResultSet result = statement.executeQuery();
			while (result.next()) {
				Order order = OrderDAO.getById(result.getInt("id"));
				orders.add(order);
			}
			statement.close();
			result.close();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return orders;
	}
	
	public static List<Order> getOrdersByDateCurrent(){
		LocalDate current = LocalDate.now();
		int month = current.getMonthValue();
		int year = current.getYear();
		return getOrdersByDate(month, year);
		
	}
	
	public static List<Order> getByUserId(int userId){
		List<Order> orders = new ArrayList<Order>();
		String sql = "SELECT * FROM order_tables\r\n"
				+ "where customer_id=? \r\n";
		try {
			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			statement.setInt(1, userId);
			ResultSet result = statement.executeQuery();
			while (result.next()) {
				Order order = OrderDAO.getById(result.getInt("id"));
				orders.add(order);
			}
			statement.close();
			result.close();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return orders;
	}
	
	public static double revenueOfMonth(int month, int year) {
		double re = 0;
		String sql = "SELECT SUM(saleprice*quantity)\r\n"
				+ "FROM order_tables ot JOIN order_details od ON ot.id=od.order_id\r\n"
				+ "where MONTH(order_date)=? AND YEAR(order_date)=?;";
		try {
			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			statement.setInt(1, month);
			statement.setInt(2, year);
			ResultSet result = statement.executeQuery();
			while (result.next()) {
				re = result.getFloat(1);
			}
			statement.close();
			result.close();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return re;
	}
	
	public static double revenueOfQuarter(int quarter, int year) {
		double re = 0;
		String sql = "SELECT SUM(saleprice*quantity)\r\n"
				+ "FROM order_tables ot JOIN order_details od ON ot.id=od.order_id\r\n"
				+ "WHERE QUARTER(order_date)=? AND YEAR(order_date)=?;";
		try {
			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			statement.setInt(1, quarter);
			statement.setInt(2, year);
			ResultSet result = statement.executeQuery();
			while (result.next()) {
				re = result.getFloat(1);
			}
			statement.close();
			result.close();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return re;
	}
	
	
//	public static void main(String[] args) {
//		new DBConnection();
//		double re = OrderDAO.revenueOfMonth(1, 2024);
//		System.out.println(re);
//	}
}

package DAO;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import Database.DBConnection;
import Model.Cart;
import Model.Order;

public class OrderDAO {
	
	/*
	 * Để thêm một order vào db
	 * 1) Thêm address vào address table(nếu address mới)
	 * 2) Thêm order
	 */
	public static boolean addOrder(Order order, Cart cart) {
		PreparedStatement statement;
		String sql;
		try {
			AddressDAO.addNewAddress(order.getOrderAddress());
	
			int idAddress  = AddressDAO.getIdByAddress(order.getOrderAddress());
			
			//add order_tables
			sql = "insert into order_tables (customer_id, address_id, order_date, coupon, payment_id, notes ) values(?,?,?,?,?,?)";
			statement = DBConnection.connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			statement.setInt(1, order.getSender().getId());
			statement.setInt(2, idAddress);
			statement.setDate(3, order.getOrderDate());
			statement.setString(4, order.getCoupon() != null ? order.getCoupon().getId(): null);
			statement.setInt(5, order.getPaymentId());
			statement.setString(6, order.getNotes());
			int result = statement.executeUpdate();
			
			
			if (result>0) {
				ResultSet rs = statement.getGeneratedKeys();
				rs.next();
				int orderId = rs.getInt(1);
				
				
				//add order_details and delete product in cart
				order.getProductAndQuantityList().forEach((product, quantity) -> {
					
					String sl;
					PreparedStatement st;
					try {
						sl = "insert into order_details values(?,?,?)"; 
						st = DBConnection.connection.prepareStatement(sl);
						st.setInt(1, orderId);
						st.setInt(2, product.getId());
						st.setInt(3, quantity);
						st.executeUpdate();
						
						
						CartDAO.deleteProduct(cart.getId(), product.getId());
						
						st.close();
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
					
				});
				
				
				//add order_receiver_infomation
				sql = "insert into order_receiver_infomation values(?,?,?,?,?)";
				statement = DBConnection.connection.prepareStatement(sql);
				statement.setInt(1, orderId);
				statement.setString(2, order.getReceiver().getFirstName());
				statement.setString(3, order.getReceiver().getLastName());
				statement.setString(4, order.getReceiver().getEmail());
				statement.setString(5, order.getReceiver().getPhone());
				
				statement.executeUpdate();
				
				
				
			}
			
			statement.close();
			return result > 0;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	}
}

package DAO;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.net.ssl.SSLSessionContext;

import org.apache.catalina.manager.util.SessionUtils;

import com.mysql.cj.Session;
import com.mysql.cj.xdevapi.SessionFactory;
import com.mysql.cj.xdevapi.SessionImpl;

import Database.DBConnection;
import Model.Cart;
import Model.Product;
import jakarta.servlet.http.HttpSession;


public class CartDAO {
	
	public static Cart getByUserId(int userId) {
		
		Cart cart = new Cart();
		String sql = "";
		try {
			//inject id cart
			sql = "select * from carts where customer_id = ?";
			
			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			
			statement.setInt(1, userId);
			
			ResultSet result = statement.executeQuery();
			while(result.next()) {	
				int id = result.getInt("id");
				cart.setId(id);
			}
			
			//inject list product of cart
			sql = "select cart_details.* from carts join cart_details on carts.id = cart_details.cart_id where customer_id = ? ";
			
			statement = DBConnection.connection.prepareStatement(sql);
			
			statement.setInt(1, userId);
			
			result = statement.executeQuery();
			
			while(result.next()) {
				Product  product = ProductDAO.getById(result.getInt("product_id"));
				int quantity = result.getInt("quantity");
				int selected = result.getInt("is_selected");
				cart.getProduct_quantity().put(product, quantity);
				cart.getProduct_selected().put(product, selected);
			}
			
			result.close();
			statement.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return cart;
	}
	
	public static boolean deleteProduct(int cartId, int product_id) {
		String sql = "delete from cart_details where cart_id = ? and product_id = ?";
		try {
			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			
			statement.setInt(1, cartId);
			statement.setInt(2, product_id);
			
			int row = statement.executeUpdate();
			statement.close();
			return row >0;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
		
	}
	
	public static boolean addProduct(int cartId, int product_id, int quantity) {
		String sql = "insert into cart_details (cart_id, product_id, quantity) values (?,?,?)";
		try {
			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			
			statement.setInt(1, cartId);
			statement.setInt(2, product_id);
			statement.setInt(3, quantity);
			
			int row =  statement.executeUpdate();
			statement.close();
			return row >0;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
		
	}
	
	public static boolean updateQuantity(int cartId, int product_id, int quantity) {
		String sql = "update cart_details set quantity = ? where cart_id = ? and product_id = ?";
		try {
			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			
			statement.setInt(1, quantity);
			statement.setInt(2, cartId);
			statement.setInt(3, product_id);
			
			int row =  statement.executeUpdate();
			statement.close();
			return row >0;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	}
	
	public static boolean updateSelected(int cartId, int product_id, int selected) {
		String sql = "update cart_details set is_selected = ? where cart_id = ? and product_id = ?";
		try {
			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			
			statement.setInt(1, selected);
			statement.setInt(2, cartId);
			statement.setInt(3, product_id);
			
			int row =  statement.executeUpdate();
			statement.close();
			return row >0;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	}
	
	public static boolean updateQuantityandSelected(int cartId, int product_id, int selected, int quantity) {
		String sql = "update cart_details set is_selected = ? , quantity = ? where cart_id = ? and product_id = ?";
		try {
			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			
			statement.setInt(1, selected);
			statement.setInt(2, quantity);
			statement.setInt(3, cartId);
			statement.setInt(4, product_id);
			
			int row =  statement.executeUpdate();
			statement.close();
			return row >0;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	}
	
}

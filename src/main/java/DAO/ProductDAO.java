package DAO;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import Database.DBConnection;
import Fillter.ProductFilter;
import Model.Product;
import Utils.DynamicPagination;
import jakarta.servlet.http.Part;

public class ProductDAO {

	public static List<Product> getAllProduct() {
		List<Product> list = new ArrayList<Product>();
		String sql = "select * from products";

		try {

			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			ResultSet result = statement.executeQuery();

			while (result.next()) {
				int id = result.getInt("id");
				Product product = getById(id);
				
				list.add(product);
			}
			
			statement.close();
			result.close();

		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return list;
	}

	public static Product getById(int id) {
		Product product = new Product();
		String sql = "select * from products where id = ?";

		try {

			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			statement.setInt(1, id);
			ResultSet result = statement.executeQuery();

			while (result.next()) {
				String name = result.getString("product_name");
				int category_id = result.getInt("category_id");
				double price = result.getDouble("price");
				
				Blob image = (Blob) result.getBlob("image");
				String des = result.getString("des");
				double percent_sale = result.getDouble("percent_sale");
				int rate = result.getInt("rate");
			

				product.setId(id);
				product.setCategoryId(category_id);
				product.setDes(des);
				product.setName(name);
				product.setPrice(price);
				product.setRate(rate);
				product.setImage(image);
				product.setPercentSale(percent_sale);
			}
			statement.close();
			result.close();

		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}

		return product;
	}

	public static List<Product> getProductByOffset(List<Product> list, int offset) {
		
		
		int beginIndex = (offset-1) * DynamicPagination.totalProductOfPage;
		int endIndex = beginIndex + DynamicPagination.totalProductOfPage;
		
		if (endIndex>list.size()) {
			endIndex = list.size();
		}
		
	
		return list.subList(beginIndex, endIndex);
	}
	
	public static List<Product> getProductByFilter(ProductFilter filter) {
		
		return getAllProduct().stream().filter((product) -> filter.accpect(product)).collect(Collectors.toList());
	}
	
	public static List<Product> getBestSale(int limit) {
		List<Product> list = getAllProduct();
		list.sort(( product1, product2) -> {
			return  product2.getRate() -  product1.getRate();
		});
		return list.subList(0, limit>list.size()?list.size():limit);
	}
	
	public static List<Product> getBestSale(int limit, int except) {
		List<Product> list = getAllProduct().stream().filter((product) -> product.getId() != except).collect(Collectors.toList());
		list.sort(( product1, product2) -> {
			return  product2.getRate() -  product1.getRate();
		});
		return list.subList(0, limit>list.size()?list.size():limit);
	}
	public static boolean delete(int id) {
		String sql = "DELETE FROM products WHERE id = ?;";
		try {
			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			statement.setInt(1, id);
			int result = statement.executeUpdate();
			statement.close();
			if(result >= 0) return true;
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
	
	// Chua xong
	// insert product in admin_product 
//	public static boolean insert(String product_name, int category_id, float price, float percent_sale, Part image, String des  ) throws IOException {
	public static boolean insert(Product product) throws IOException {
		String sql = "INSERT INTO products (product_name, category_id, price, percent_sale, image, des) \r\n"
				+ "VALUES (?, ?, ?, ?, ?, ?);";
		try {
			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			statement.setString(1, product.getName());
			statement.setInt(2, product.getCategoryId());
			statement.setFloat(3,(float) product.getPrice() );
			statement.setFloat(4, (float) product.getPercentSale());
			statement.setBlob(5, product.getImage());
			statement.setString(6, product.getDes());
			int result = statement.executeUpdate();
			statement.close();
			if(result > 0) return true;
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return false;
		
	}
	// update admin_product
	public static boolean update(Product product) {
		String sql = "UPDATE products \r\n"
				+ "SET product_name = ?,\r\n"
				+ "	category_id =  ?,\r\n"
				+ "    des = ?,\r\n"
				+ "    price = ?,\r\n"
				+ "    percent_sale = ?,\r\n"
				+ "    image = ?\r\n"
				+ "    WHERE (id = ?);";
		try {
			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			statement.setString(1, product.getName());
			statement.setInt(2, product.getCategoryId());
			statement.setString(3, product.getDes());
			statement.setFloat(4, (float) product.getPrice());
			statement.setFloat(5, (float) product.getPercentSale());
			statement.setBlob(6, product.getImage());
			statement.setInt(7, product.getId());
			int result = statement.executeUpdate();
			statement.close();
			if(result>0) return true;
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return false;
	}
	
}

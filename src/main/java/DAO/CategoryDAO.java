package DAO;

import java.sql.Blob;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Database.DBConnection;
import Model.Category;
import Model.Product;

public class CategoryDAO {
	public static List<Category> getAllCategory() {
		List<Category> list = new ArrayList<Category>();
		String sql = "select * from categorys";

		try {

			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			ResultSet result = statement.executeQuery();

			while (result.next()) {
				int id = result.getInt("id");
				Category category = getById(id);
				
				list.add(category);
			}
			
			statement.close();
			result.close();

		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		

		return list;
	}

	public static Category getById(int id) {
		Category category = new Category();
		String sql = "select * from categorys where id = ?";

		try {

			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			statement.setInt(1, id);
			ResultSet result = statement.executeQuery();

			while (result.next()) {
				String name = result.getString("name_category");

				category.setId(id);
				category.setName(name);
			}
			statement.close();
			result.close();

		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}

		return category;
	}
	public static boolean delete(int id) {
		String sql = "DELETE FROM categorys WHERE (id = ?);";
		try {

			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			statement.setInt(1, id);
			int result = statement.executeUpdate();

			if(result>=0) return true;
			
			statement.close();
		} catch (SQLException e) {
			if ("45000".equals(e.getSQLState())) {
                // Xử lý khi gặp lỗi "Cannot delete user with orders"
                System.out.println("CategoryDAO: Cannot delete category.");
                return false;
            }
			// TODO: handle exception
			e.printStackTrace();
		}
		return false;
	}
	public static boolean update(int id, String name) {
		String sql = "UPDATE categorys SET name_category = ? WHERE (id = ?);";
		try {

			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			statement.setString(1, name);
			statement.setInt(2, id);
			int result = statement.executeUpdate();

			if(result>=0) return true;
			
			statement.close();
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return false;
	}
	
	public static boolean insert(String name) {
		String sql = "INSERT INTO categorys (name_category) VALUES (?);";
		try {

			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			statement.setString(1, name);
			int result = statement.executeUpdate();

			if(result>0) return true;
			
			statement.close();
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return false;
	}
	public static void main(String[] args) {
		new DBConnection();
//		List<Category>  re =  CategoryDAO.getAllCategory();
//		System.out.println(re.get(0).getName());
		boolean check = CategoryDAO.insert("Office furniture 2");
		System.out.println(check);
	}
}

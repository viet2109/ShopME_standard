package DAO;

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
	
}

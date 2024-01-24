package DAO;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Database.DBConnection;
import Model.Category;
import Model.Payment;

public class PaymentDAO {
	public static List<Payment> getAll() {
		List<Payment> list = new ArrayList<Payment>();
		String sql = "select * from payments";

		try {

			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			ResultSet result = statement.executeQuery();

			while (result.next()) {
				int id = result.getInt("id");
				Payment category = getById(id);
				
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
	public static Payment getById(int id) {
		Payment payment = new Payment();
		String sql = "select * from payments where id = ?";

		try {

			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			statement.setInt(1, id);
			ResultSet result = statement.executeQuery();

			while (result.next()) {
				String name = result.getString("pay_name");

				payment.setId(id);
				payment.setName(name);
			}
			statement.close();
			result.close();

		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}

		return payment;
	}
}

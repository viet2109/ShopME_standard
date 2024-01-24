package DAO;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import Database.DBConnection;
import Model.Coupon;

public class CouponDAO {
	public static Coupon getById(String id) {
		Coupon coupon = null;
		try {
			String sql = "select * from coupons where id = ?";
			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			statement.setString(1, id);
			
			ResultSet result = statement.executeQuery();
			
			while (result.next()) {
				coupon = new Coupon();
				coupon.setId(id);
				double percentSale = result.getDouble("percent");
				coupon.setPercentSale(percentSale);
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		return coupon;
	}
	public static List<Coupon> getAll() {
		List<Coupon> coupons = new ArrayList<Coupon>();
		try {
			String sql = "select * from coupons ";
			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			
			ResultSet result = statement.executeQuery();
			
			while (result.next()) {
				Coupon coupon = new Coupon();
				coupon.setId(result.getString(1));
				double percentSale = result.getDouble("percent");
				coupon.setPercentSale(percentSale);
				coupons.add(coupon);
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		return coupons;
	}
}

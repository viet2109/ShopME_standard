package DAO;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

import Database.DBConnection;
import Model.Address;
import Model.User;

public class AddressDAO {

	public static Address getByid(int id) {
		Address address = null;
		try {
			String sql = "select * from address_tables where id = ?";
			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			statement.setInt(1, id);

			ResultSet result = statement.executeQuery();

			while (result.next()) {
				address = new Address();
				address.setId(id);
				String province = result.getString("province");
				String district = result.getString("district");
				String ward = result.getString("ward");
				String addressDetail = result.getString("address_detail");

				address.setCountry(province);
				address.setCity(district);
				address.setWard(ward);
				address.setDetailAddress(addressDetail);
			}

		} catch (Exception e) {
			// TODO: handle exception
		}
		return address;
	}

	public static int getIdByAddress(Address address) {
		try {
			String sql = "select * from address_tables where province = ? and district = ? and ward = ? and address_detail = ?";
			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			statement.setString(1, address.getCountry());
			statement.setString(2, address.getCity());
			statement.setString(3, address.getWard());
			statement.setString(4, address.getDetailAddress());

			ResultSet result = statement.executeQuery();

			while (result.next()) {
				return result.getInt("id");
			}

		} catch (Exception e) {
			// TODO: handle exception
		}
		return -1;
	}
	
	
	public static boolean addNewAddress(Address address) {
		try {
			System.out.println("AddressDAO: "+address);
			String sql = "insert into address_tables (province, district, ward, address_detail) values(?,?,?,?)";
			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			statement.setString(1, address.getCountry());
			statement.setString(2, address.getCity());
			statement.setString(3, address.getWard());
			statement.setString(4, address.getDetailAddress());

			int result = statement.executeUpdate();

			return result == 1;

		} catch (Exception e) {
			// TODO: handle exception
			return false;
		}
	}
	public static boolean addNewUserAddress(Address address, User user) {
		try {
			String sql = "insert into customer_addresses (customer_id, address_id) values(?,?)";
			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			statement.setInt(1, user.getId());
			statement.setInt(2, address.getId());
			int result = statement.executeUpdate();

			return result == 1;

		} catch (Exception e) {
			// TODO: handle exception
			return false;
		}
	}
	public static Address getByUserId(int userId) {
		try {
			String sql = "SELECT at.* FROM customer_addresses ca JOIN address_tables at ON ca.address_id=at.id "
					+ "WHERE customer_id=? AND defaut=1;\r\n";
			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			statement.setInt(1, userId);
			ResultSet result = statement.executeQuery();
			Address address = null;
			while(result.next()) {
				int id = result.getInt("id");
				String province = result.getString("province");
				String district = result.getString("district");
				String ward = result.getString("ward");
				String addressDetail = result.getString("address_detail");
				address = new Address(id, province, district, ward, addressDetail);
				break;
			}
			result.close();
			statement.close();
			return address;

		} catch (Exception e) {
			// TODO: handle exception
			return null;
		}
	}
	
	public static boolean updateDefautCustomerAddresses(int userId, int addressId) {
		try {
			String sql = "CALL UpdateCustomerAddressDefault(?, ?);";
			PreparedStatement statement = DBConnection.connection.prepareStatement(sql);
			statement.setInt(1, userId);
			statement.setInt(2, addressId);
			int result = statement.executeUpdate();
			if(result >= 0) return true;

		} catch (Exception e) {
			// TODO: handle exception
			return false;
		}
		return false;
	}
	
//	public static void main(String[] args) {
//		new DBConnection();
//		Address a = AddressDAO.getByid(16);
//		a.setId(0);
//		int check = AddressDAO.getIdByAddress(a);
//		
//	}
}

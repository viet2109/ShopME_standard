package Database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	public static Connection connection;
	public static String dbUri = "jdbc:mysql://localhost:3306/shopdb_standard";
	public static String dbUserName = "root";
	public static String dbUserPassWord = "nhv21092003@";
	public static String driver = "com.mysql.cj.jdbc.Driver";
	public DBConnection() {
		if (connection==null) {
			
			try {
				Class.forName(driver);
				connection = DriverManager.getConnection(dbUri, dbUserName, dbUserPassWord);

			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}

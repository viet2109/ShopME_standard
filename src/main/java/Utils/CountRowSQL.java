package Utils;

import java.sql.ResultSet;
import java.sql.SQLException;

public class CountRowSQL {
	private ResultSet result;

	public CountRowSQL(ResultSet result) {
		this.result = result;
	}
	
	public int getRow() {
		int row=0;
		try {
			while(result.next()) {
				row++;
			}
			result.beforeFirst();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return row;
	}
	
}

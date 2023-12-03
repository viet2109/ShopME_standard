package Utils;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.Date;

public class MathUtils {
	public static int roundUp(int x1, int x2) {
		return Math.ceilDiv(x1, x2);
	}
	
	public static boolean isNumber(String x) {
		try {
			Integer.parseInt(x);
			
			return true;
		} catch (Exception e) {
			return false;
		}
	}
	
	public static String arrayString(String[] x) {
		return Arrays.toString(x);
	}
	
	public static Date convertToDate(LocalDateTime locaDate) {
		
		Timestamp timeStamp = Timestamp.valueOf(locaDate);
		
		return new Date(timeStamp.getTime());
	}
	
	
	public static void main(String[] args) {
		
		System.out.println("hghg".contains("hg"));
	}
}

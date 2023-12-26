package Utils;

import java.sql.Blob;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import Fillter.*;
import Model.Cart;
import Model.Product;

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

	public static String arrayString(int[] x) {
		return Arrays.toString(x);
	}

	public static Date convertToDate(LocalDateTime locaDate) {

		Timestamp timeStamp = Timestamp.valueOf(locaDate);

		return new Date(timeStamp.getTime());
	}

	public static int[] convertStrArrToIntArr(String[] strArr) {
		return Arrays.stream(strArr).mapToInt(Integer::parseInt).toArray();
	}

	public static String covertBlobToByteString(Blob blob) {
		// Loại bỏ ký tự không cần thiết khỏi chuỗi
		try {
			return Base64.getEncoder().encodeToString(blob.getBytes(1, (int) blob.length()));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			return "";
		}
	}
	
	public static double totalPriceCart(Cart cart) {
		double[] sum = {0};
		
		
		cart.getProduct_quantity().forEach((product, quantity) -> {
			
			if (cart.getProduct_selected().get(product) == 1) {
				
				sum[0] += (product.getPrice()*product.getPercentSale()*quantity);
			}
			
		});
		
		return sum[0];
	}

	public static void main(String[] args) {
		System.out.println(1-1*2);
	}
}

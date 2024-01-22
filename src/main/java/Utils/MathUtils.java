package Utils;

import java.sql.Blob;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import Fillter.*;
import Model.Cart;
import Model.Order;
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

	public static String extractLocation(String text) {
        // Tách chuỗi thành các từ
        String[] words = text.split("\\s+");

        // Tìm các từ có thể là tên địa điểm
        StringBuilder locationBuilder = new StringBuilder();
        for (String word : words) {
            // Loại bỏ các ký tự đặc biệt và chấp nhận chữ cái và dấu cách
            String cleanedWord = word.replaceAll("[^a-zA-Z\\s]", "").trim();

            // Kiểm tra nếu từ có ít nhất 2 ký tự (ít nhất là "xa", "thị trấn", "thành phố", ...)
            if (cleanedWord.length() >= 2) {
                locationBuilder.append(cleanedWord).append(" ");
            }
        }

        return locationBuilder.toString().trim();
    }
	
	public static StringBuilder ConvertOrderToJson(List<Order> orders) {
		StringBuilder jsonBuilder = new StringBuilder("[");
        for (Order order : orders) {
            jsonBuilder.append("{")
                       .append("\"id\":").append(order.getId()).append(",")
                       .append("\"customerName\":\"").append(order.getReceiver().getLastName()).append(" ").append(order.getReceiver().getFirstName()).append("\",")
                       .append("\"date\":\"").append(order.getOrderDate()).append("\",")
                       .append("\"total\":").append(order.totalOrder()).append(",")
                       .append("\"payment\":\"").append(order.getPayment().getName()).append("\"")
                       .append("},");
        }
        if (orders.size() > 0) {
            jsonBuilder.deleteCharAt(jsonBuilder.length() - 1); // Remove the last comma
        }
        jsonBuilder.append("]");
        return jsonBuilder;
	}

    public static void main(String[] args) {
        java.sql.Date date = java.sql.Date.valueOf(LocalDate.now());
        java.sql.Timestamp timestamp = java.sql.Timestamp.valueOf(java.time.LocalDateTime.now());
        System.out.println(timestamp);
    }
}

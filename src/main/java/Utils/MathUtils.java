package Utils;

import java.util.Arrays;

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
	
	
	public static void main(String[] args) {
		System.out.println(MathUtils.roundUp(3, 2));
	}
}

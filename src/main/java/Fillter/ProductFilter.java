package Fillter;

import java.lang.reflect.Field;
import java.util.Arrays;

import Model.Product;
import Utils.MathUtils;

public class ProductFilter {

	private int[] price;
	private int[] star;

	public ProductFilter() {
		
	}

	public boolean accpect(Product product) {
		Class<?> clazz = ProductFilter.class;

		// Lấy danh sách fields của class
		Field[] fields = clazz.getDeclaredFields();

		// Kiểm tra giá trị của từng field
		for (Field field : fields) {
			field.setAccessible(true); // Đặt quyền truy cập để có thể truy cập private fields

			// Lấy giá trị của field từ instance
			Object value = null;
			try {
				value = field.get(this);
			} catch (IllegalArgumentException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
			// Kiểm tra giá trị
			if (value != null) {
				
				// check price
				if (field.getName().equals("price")) {				
					if (product.getPrice() > price[1] || product.getPrice() < price[0])
						return false;
				}

				// check star
				if (field.getName().equals("star")) {
					
					if (!Arrays.stream(star).anyMatch(num -> num == product.getRate()))
						return false;
				}
			}
		}

		return true;
	}

	public int[] getPrice() {
		return price;
	}

	public void setPrice(int[] price) {
		this.price = price;
	}
	
	public void setPrice(String[] price) {
		setPrice(MathUtils.convertStrArrToIntArr(price));
	}

	public int[] getStar() {
		return star;
	}

	public void setStar(int[] star) {
		this.star = star;
	}
	
	public void setStar(String[] star) {
		setStar(MathUtils.convertStrArrToIntArr(star));
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + Arrays.hashCode(price);
		result = prime * result + Arrays.hashCode(star);
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ProductFilter other = (ProductFilter) obj;
		return Arrays.equals(price, other.price) && Arrays.equals(star, other.star);
	}

	@Override
	public String toString() {
		return "ProductFilter [price=" + Arrays.toString(price) + ", star=" + Arrays.toString(star) + "]";
	}

}

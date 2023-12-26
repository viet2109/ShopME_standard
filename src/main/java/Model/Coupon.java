package Model;

import java.util.Objects;

public class Coupon {
	private String id;
	private double percentSale;

	public Coupon(String id, double percentSale) {
		this.id = id;
		this.percentSale = percentSale;
	}

	public Coupon() {
	}

	@Override
	public int hashCode() {
		return Objects.hash(id, percentSale);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Coupon other = (Coupon) obj;
		return Objects.equals(id, other.id) && percentSale == other.percentSale;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public double getPercentSale() {
		return percentSale;
	}

	public void setPercentSale(double percentSale) {
		this.percentSale = percentSale;
	}

}

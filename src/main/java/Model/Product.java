package Model;

import java.sql.Blob;
import java.util.Objects;



public class Product {

	private int id;
	private String name;
	private int categoryId;
	private String des;
	private double price;
	private double percentSale;
	private int rate;
	private Blob image;
	

	public Product(int id, String name, int categoryId, String des, double price, double percentSale, int rate,
			Blob image) {
		this.id = id;
		this.name = name;
		this.categoryId = categoryId;
		this.des = des;
		this.price = price;
		this.percentSale = percentSale;
		this.rate = rate;
		this.image = image;
	}
	

	public Product(String name, int categoryId, String des, double price, double percentSale, Blob image) {
		super();
		this.name = name;
		this.categoryId = categoryId;
		this.des = des;
		this.price = price;
		this.percentSale = percentSale;
		this.image = image;
	}
	

	public Product(int id, String name, int categoryId, String des, double price, double percentSale, Blob image) {
		super();
		this.id = id;
		this.name = name;
		this.categoryId = categoryId;
		this.des = des;
		this.price = price;
		this.percentSale = percentSale;
		this.image = image;
	}


	@Override
	public String toString() {
		return "Product [id=" + id + ", name=" + name + ", categoryId=" + categoryId + ", des=" + des + ", price="
				+ price + ", percentSale=" + percentSale + ", rate=" + rate + ", image=" + image + "]";
	}

	@Override
//	public int hashCode() {
//		return Objects.hash(categoryId, des, image, name, percentSale, price, rate);
//	}
	public int hashCode() {
		return Objects.hash(categoryId, des, name, percentSale, price, rate);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Product other = (Product) obj;
		return categoryId == other.categoryId
		        && Objects.equals(des, other.des)
//		        && Objects.equals(image, other.image)
		        && Objects.equals(name, other.name)
		        && Double.doubleToLongBits(percentSale) == Double.doubleToLongBits(other.percentSale)
		        && Double.doubleToLongBits(price) == Double.doubleToLongBits(other.price)
		        && rate == other.rate;
	}

	public Product() {
	}

	public Product(String name, int categoryId, String des, double price, double percentSale, int rate, Blob image) {
		this.name = name;
		this.categoryId = categoryId;
		this.des = des;
		this.price = price;
		this.percentSale = percentSale;
		this.rate = rate;
		this.image = image;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}

	public String getDes() {
		return des;
	}

	public void setDes(String des) {
		this.des = des;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public double getPercentSale() {
		return percentSale;
	}

	public void setPercentSale(double percentSale) {
		this.percentSale = percentSale;
	}

	public int getRate() {
		return rate;
	}

	public void setRate(int rate) {
		this.rate = rate;
	}

	public Blob getImage() {
		
		return image;
	}

	public void setImage(Blob image) {
		this.image = image;
	}

}

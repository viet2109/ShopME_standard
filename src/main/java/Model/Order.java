package Model;

import java.sql.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

import org.apache.jasper.tagplugins.jstl.core.ForEach;

public class Order {

	private int id;
	private User sender;
	private Address orderAddress;
	private Date orderDate;
	private Coupon coupon;
	private Payment payment;
	private Map<Product, Integer> productAndQuantityList;
	private User receiver;
	private String notes;
	private Map<Product, Double> price;// 

	
	public Order(int id, User sender, Address orderAddress, Date orderDate, Coupon coupon, Payment payment,
			Map<Product, Integer> productAndQuantityList, User receiver, String notes, Map<Product, Double> price) {
		this.id = id;
		this.sender = sender;
		this.orderAddress = orderAddress;
		this.orderDate = orderDate;
		this.coupon = coupon;
		this.payment = payment;
		this.productAndQuantityList = productAndQuantityList;
		this.receiver = receiver;
		this.notes = notes;
		this.price = price;
	}

	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}

	public Map<Product, Double> getPrice() {
		return price;
	}

	public void setPrice(Map<Product, Double> price) {
		this.price = price;
	}

	public Order() {

		productAndQuantityList = new HashMap<Product, Integer>();
	}

	public Order(int id, User sender, Address orderAddress, Date orderDate, Coupon coupon, Payment payment,
			Map<Product, Integer> productAndQuantityList, User receiver) {
		this.id = id;
		this.sender = sender;
		this.orderAddress = orderAddress;
		this.orderDate = orderDate;
		this.coupon = coupon;
		this.payment = payment;
		this.productAndQuantityList = productAndQuantityList;
		this.receiver = receiver;
	}

	public Order(User sender, Address orderAddress, Date orderDate, Coupon coupon, Payment payment,
			Map<Product, Integer> productAndQuantityList, User receiver) {
		this.sender = sender;
		this.orderAddress = orderAddress;
		this.orderDate = orderDate;
		this.coupon = coupon;
		this.payment = payment;
		this.productAndQuantityList = productAndQuantityList;
		this.receiver = receiver;
	}

	@Override
	public int hashCode() {
		return Objects.hash(coupon, id, orderAddress, orderDate, payment, productAndQuantityList, receiver, sender);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Order other = (Order) obj;
		return Objects.equals(coupon, other.coupon) && id == other.id
				&& Objects.equals(orderAddress, other.orderAddress) && Objects.equals(orderDate, other.orderDate)
				&& payment == other.payment && Objects.equals(productAndQuantityList, other.productAndQuantityList)
				&& Objects.equals(receiver, other.receiver) && Objects.equals(sender, other.sender);
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public User getSender() {
		return sender;
	}

	public void setSender(User sender) {
		this.sender = sender;
	}

	public Address getOrderAddress() {
		return orderAddress;
	}

	public void setOrderAddress(Address orderAddress) {
		this.orderAddress = orderAddress;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public Coupon getCoupon() {
		return coupon;
	}

	public void setCoupon(Coupon coupon) {
		this.coupon = coupon;
	}

	public Payment getPayment() {
		return payment;
	}

	public void setPayment(Payment payment) {
		this.payment = payment;
	}

	public Map<Product, Integer> getProductAndQuantityList() {
		return productAndQuantityList;
	}

	public void setProductAndQuantityList(Map<Product, Integer> productAndQuantityList) {
		this.productAndQuantityList = productAndQuantityList;
	}

	public User getReceiver() {
		return receiver;
	}

	public void setReceiver(User receiver) {
		this.receiver = receiver;
	}
	

	public double totalOrder() {
		double total = 0;
		for (Product p : price.keySet()) {
			total += price.get(p)*productAndQuantityList.get(p);
		}
		return total;
	}
}

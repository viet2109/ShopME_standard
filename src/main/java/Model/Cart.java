package Model;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

public class Cart {

	private int id;

	private Map<Product, Integer> product_quantity;

	private Map<Product, Integer> product_selected;

	public Cart(int id, Map<Product, Integer> product_quantity, Map<Product, Integer> product_selected) {
		this.id = id;
		this.product_quantity = product_quantity;
		this.product_selected = product_selected;
	}

	public Cart() {
		this.product_quantity = new HashMap<Product, Integer>();
		this.product_selected = new HashMap<Product, Integer>();
	}

	public Cart(Map<Product, Integer> product_quantity, Map<Product, Integer> product_selected) {
		this.product_quantity = product_quantity;
		this.product_selected = product_selected;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Map<Product, Integer> getProduct_quantity() {
		return product_quantity;
	}

	public void setProduct_quantity(Map<Product, Integer> product_quantity) {
		this.product_quantity = product_quantity;
	}

	public Map<Product, Integer> getProduct_selected() {
		return product_selected;
	}

	public void setProduct_selected(Map<Product, Integer> product_selected) {
		this.product_selected = product_selected;
	}

	@Override
	public String toString() {
		return "Cart [id=" + id + ", product_quantity=" + product_quantity + ", product_selected=" + product_selected
				+ "]";
	}

	@Override
	public int hashCode() {
		return Objects.hash(id, product_quantity, product_selected);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Cart other = (Cart) obj;
		return id == other.id && Objects.equals(product_quantity, other.product_quantity)
				&& Objects.equals(product_selected, other.product_selected);
	}

}

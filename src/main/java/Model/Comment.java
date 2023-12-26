package Model;

import java.sql.Date;
import java.util.Objects;

public class Comment {

	private int id;
	private User user;
	private Product product;
	private String content;
	private Date create_date;
	private int rate;

	public Comment(int id, User user, Product product, String content, Date create_date, int rate) {
		this.id = id;
		this.user = user;
		this.product = product;
		this.content = content;
		this.create_date = create_date;
		this.rate = rate;
	}

	public Comment(User user, Product product, String content, Date create_date, int rate) {
		this.user = user;
		this.product = product;
		this.content = content;
		this.create_date = create_date;
		this.rate = rate;
	}

	public Comment() {
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getCreate_date() {
		return create_date;
	}

	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
	}

	public int getRate() {
		return rate;
	}

	public void setRate(int rate) {
		this.rate = rate;
	}

	@Override
	public int hashCode() {
		return Objects.hash(content, create_date, id, product, rate, user);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Comment other = (Comment) obj;
		return Objects.equals(content, other.content) && Objects.equals(create_date, other.create_date)
				&& id == other.id && Objects.equals(product, other.product) && rate == other.rate
				&& Objects.equals(user, other.user);
	}

	@Override
	public String toString() {
		return "Comment [id=" + id + ", user=" + user + ", product=" + product + ", content=" + content
				+ ", create_date=" + create_date + ", rate=" + rate + "]";
	}

}

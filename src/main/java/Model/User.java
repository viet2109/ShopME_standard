package Model;

import java.sql.Date;
import java.util.Objects;

public class User {
	private int id;
	private String firstName;
	private String lastName;
	private String email;
	private String phone;
	private Date dob;
	private String password;
	private Address address;
	public Address getAddress() {
		return address;
	}

	public void setAddress(Address address) {
		this.address = address;
	}

	private int roles;

	public User() {
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Date getDob() {
		return dob;
	}

	public void setDob(Date dob) {
		this.dob = dob;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getRoles() {
		return roles;
	}

	public void setRoles(int roles) {
		this.roles = roles;
	}
	
	public String getFullName() {
		return lastName + " " + firstName;
	}
	
	@Override
	public int hashCode() {
		return Objects.hash(dob, email, firstName, id, lastName, password, phone, roles);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		User other = (User) obj;
		return Objects.equals(dob, other.dob) && Objects.equals(email, other.email)
				&& Objects.equals(firstName, other.firstName) && id == other.id
				&& Objects.equals(lastName, other.lastName) && Objects.equals(password, other.password)
				&& Objects.equals(phone, other.phone) && roles == other.roles;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", firstName=" + firstName + ", lastName=" + lastName + ", email=" + email
				+ ", phone=" + phone + ", dob=" + dob + ", password=" + password + ", roles=" + roles + "]";
	}

	public User(String firstName, String lastName, String email, String phone, Date dob, String password, int roles) {
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.phone = phone;
		this.dob = dob;
		this.password = password;
		this.roles = roles;
	}

	public User(int id, String firstName, String lastName, String email, String phone, Date dob, String password,
			int roles) {
		this.id = id;
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.phone = phone;
		this.dob = dob;
		this.password = password;
		this.roles = roles;
	}

}

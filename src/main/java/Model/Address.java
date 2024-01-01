package Model;

import java.util.Objects;

public class Address {
	
	private int id;
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Address(int id, String country, String city, String ward, String detailAddress) {
		this.id = id;
		this.country = country;
		this.city = city;
		this.ward = ward;
		this.detailAddress = detailAddress;
	}

	private String country;
	private String city;
	private String ward;
	private String detailAddress;
	
	public Address(String country, String city, String ward, String detailAddress) {
		this.country = country;
		this.city = city;
		this.ward = ward;
		this.detailAddress = detailAddress;
	}

	public Address() {
		// TODO Auto-generated constructor stub
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getWard() {
		return ward;
	}

	public void setWard(String ward) {
		this.ward = ward;
	}

	public String getDetailAddress() {
		return detailAddress;
	}

	public void setDetailAddress(String detailAddress) {
		this.detailAddress = detailAddress;
	}

	@Override
	public int hashCode() {
		return Objects.hash(city, country, detailAddress, id, ward);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Address other = (Address) obj;
		return Objects.equals(city, other.city) && Objects.equals(country, other.country)
				&& Objects.equals(detailAddress, other.detailAddress) && id == other.id
				&& Objects.equals(ward, other.ward);
	}
	
	
	
}

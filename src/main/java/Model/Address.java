package Model;

import java.util.Objects;

public class Address {
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
		return Objects.hash(city, country, detailAddress, ward);
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
				&& Objects.equals(detailAddress, other.detailAddress) && Objects.equals(ward, other.ward);
	}
	
	
	
}

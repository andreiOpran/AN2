package L5.MiniAplicatie;

public final class Address {
	private final String city;
	private final String street;

	public Address(String city, String street) {
		this.city = city;
		this.street = street;
	}

	public String getCity() {
		return city;
	}
	public String getStreet() {
		return street;
	}

	@Override
	public String toString() {
		return "Address{" +
				"city='" + city + '\'' +
				", street='" + street + '\'' +
				'}';
	}
}

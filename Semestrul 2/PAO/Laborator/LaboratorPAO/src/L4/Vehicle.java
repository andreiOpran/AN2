package L4;

public class Vehicle {
	String brand;
	int year;

	public Vehicle(String brand, int year) {
		this.brand = brand;
		this.year = year;
	}

	public String displayInfo() {
		return "Vehicle{" +
				"brand='" + brand + '\'' +
				", year=" + year +
				'}';
	}
}


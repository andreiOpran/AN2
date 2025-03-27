package L4;

public class Car extends Vehicle {

	int numberOfDoors;

	public Car(String brand, int year, int numberOfDoors) {
		super(brand, year);
		this.numberOfDoors = numberOfDoors;
	}

	@Override
	public String displayInfo() {
		return "Car{" +
				"brand='" + brand + '\'' +
				", year=" + year +
				", numberOfDoors=" + numberOfDoors +
				'}';
	}

}

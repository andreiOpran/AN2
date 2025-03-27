package L4;

public class Motorcycle extends Vehicle2 implements Insurable {

	String brand;
	int engineCapacity;

	@Override
	public double getInsuraceCost() {
		return engineCapacity * 1.5;
	}

	@Override
	public void drive() {
		System.out.println("Motorcycle " + brand + " is driving");
	}
}

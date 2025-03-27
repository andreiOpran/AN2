package L4;

public class Circle extends Shape implements Colorable {
	double radius;

	public Circle(double radius) {
		this.radius = radius;
	}

	@Override
	double getArea() {
		return Math.PI * radius * radius;
	}

	@Override
	public String getColor() {
		return "blue";
	}
}

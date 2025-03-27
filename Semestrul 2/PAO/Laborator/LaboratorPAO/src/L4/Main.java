package L4;

import java.util.ArrayList;

public class Main {

	public static void main(String[] args) {
		MathUtil obj = new MathUtil();
		System.out.println(obj.multiply(2, 3));
		System.out.println(obj.multiply(2.5, 3.5, 4.5));
		System.out.println(obj.multiply(new int[]{1, 2, 3, 4}));

		System.out.println();

		Vehicle v = new Vehicle("Dacia", 2020);
		Car c = new Car("BMW", 2021, 4);
		System.out.println(v.displayInfo());
		System.out.println(c.displayInfo());

		System.out.println();

		Animal[] animals = new Animal[2];
		animals[0] = new Dog();
		animals[1] = new Cat();
		for (Animal a : animals) {
			a.makeSound();
		}

		System.out.println();

		Motorcycle m = new Motorcycle();
		m.brand = "KTM";
		m.engineCapacity = 1100;
		m.drive();
		System.out.println(m.getInsuraceCost());

		System.out.println();

		Printer p = new Printer();
		ColorPrinter cp = new ColorPrinter();
		p.print("Hello");
		p.print(5);
		cp.print("Hello");
		cp.print(5);

		System.out.println();

		ArrayList<Shape> shapes = new ArrayList<>();
		shapes.add(new Rectangle(20, 30));
		shapes.add(new Circle(10));
		for (Shape shape : shapes) {
			System.out.print(shape.getArea() + " ");
			if (shape instanceof Circle) {
				System.out.print(((Circle) shape).getColor());
			}
			System.out.println();
		}

		System.out.println();

		shapes.sort(Shape.compareByArea);
		for (Shape shape : shapes) {
			System.out.print(shape.getArea() + " ");
			if (shape instanceof Circle) {
				System.out.print(((Circle) shape).getColor());
			}
			System.out.println();
		}

	}
}


package L6;

import java.util.*;

import static java.lang.Integer.MAX_VALUE;
import java.util.Collections;
import java.util.Comparator;

public class Main {

	public static void readInteger() {
		Scanner scanner = new Scanner(System.in);
		try {
			int x;
			System.out.print("Enter an integer: ");
			String input = scanner.nextLine();
			x = Integer.parseInt(input);
			System.out.println("You entered: " + x);
		} catch (NumberFormatException e) {
			System.out.println("Invalid input: " + e.getMessage());
		} finally {
			System.out.println("Function readInteger has ended.");
		}
	}

	public static int parseAndDivide(String a, String b) {
		try {
			int x = Integer.parseInt(a);
			int y = Integer.parseInt(b);
			return x / y;
		} catch(NumberFormatException e) {
			System.out.println("NumberFormatException: " + e.getMessage());
		} catch(ArithmeticException e) {
			System.out.println("ArithmeticException: " + e.getMessage());
		}
		finally {
			System.out.println("Function parseAndDivide has ended.");
		}
		return MAX_VALUE;
	}

	public static class InvalidGradeException extends Exception {
		public InvalidGradeException(String message) {
			super(message);
		}
	}

	public static void validateGrade(int grade) throws InvalidGradeException {
		if (grade < 1 || grade > 10) {
			throw new InvalidGradeException("Grade " + grade + " is outside of range [1, 10]");
		}
	}

	public static void main(String[] args) {
//		readInteger();

//		System.out.println(parseAndDivide("abc", "ab"));

//		try {
//			int grade = 11;
//			validateGrade(grade);
//			System.out.println("Grade " + grade + " is valid.");
//		} catch (InvalidGradeException e) {
//			System.out.println("InvalidGradeException: " + e.getMessage());
//		} finally {
//			System.out.println("Function validateGrade has ended.");
//		}

//		Shape[] shapes = new Shape[2];
//		shapes[0] = new Circle(1);
//		shapes[1] = new Rectangle(4, 2);
//		for (Shape shape : shapes) {
//			System.out.println(shape.toString());
//			System.out.println("Area: " + shape.getArea());
//			System.out.println("Perimeter: " + shape.getPerimeter());
//			System.out.println();
//		}

//		Student[] students = new Student[3];
//		students[0] = new Student("Andrei 1", 9.5);
//		students[1] = new Student("Marius 3", 8.2);
//		students[2] = new Student("Alex 2", 8.5);
//		for (Student student : students) {
//			System.out.println(student.toString());
//		}
//		System.out.println("Sorted students by average grade:");
//		Arrays.sort(students);
//		for (Student student : students) {
//			System.out.println(student.toString());
//		}

		ArrayList<Product> products = new ArrayList<>();
		products.add(new Product("Product 1", 10.0));
		products.add(new Product("Product 2", 20.0));
		products.add(new Product("Product 3", 15.0));
		System.out.println("Unsorted products:");
		Iterator<Product> iterator = products.iterator();
		while (iterator.hasNext()) {
			System.out.println(iterator.next());
		}
		Collections.sort(products, new Comparator<Product>() {
			@Override
			public int compare(Product p1, Product p2) {
				return Double.compare(p1.price, p2.price);
			}
		});
		System.out.println("Sorted products by price:");
		iterator = products.iterator();
		while (iterator.hasNext()) {
			System.out.println(iterator.next());
		}

	}
}

// bioinformatica

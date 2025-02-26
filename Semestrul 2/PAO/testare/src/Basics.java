public class Basics {
	// Method to print a greeting message
	public static void printGreeting(String name) {
		System.out.println("Hello, " + name + "!");
	}

	// Method to demonstrate a loop
	public static void printNumbers(int limit) {
		for (int i = 1; i <= limit; i++) {
			System.out.println("Number: " + i);
		}
	}

	// Method to demonstrate conditionals
	public static void checkEvenOdd(int number) {
		if (number % 2 == 0) {
			System.out.println(number + " is even.");
		} else {
			System.out.println(number + " is odd.");
		}
	}

	public static void main(String[] args) {
		// Variables
		String name = "Andrei";
		int number = 5;

		// Print greeting
		printGreeting(name);
		// Print numbers from 1 to 5
		printNumbers(number);

		// Check if the number is even or odd
		checkEvenOdd(number);
	}
}
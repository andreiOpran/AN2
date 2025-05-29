package L9;

import java.util.Scanner;

public class E3 {
	public static void main(String[] args) {
		System.out.println("Type \"stop\" to terminate the thread:");

		InfinitePrintThread thread = new InfinitePrintThread();
		thread.start();

		Scanner scanner = new Scanner(System.in);
		String input = scanner.nextLine();
		if ("stop".equalsIgnoreCase(input)) {
			thread.interrupt();
			System.out.println("Thread interrupted by user.");
		}

		scanner.close();

		try {
			thread.join(); // Wait for the thread to finish
		} catch (InterruptedException e) {
			System.out.println("Main thread interrupted: " + e.getMessage());
		}

		System.out.println("Main thread exiting...");
	}
}

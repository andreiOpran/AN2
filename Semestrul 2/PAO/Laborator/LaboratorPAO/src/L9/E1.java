package L9;

public class E1 {
	public static void main(String[] args) {
		MyThread thread1 = new MyThread('A');
		MyThread thread2 = new MyThread('B');
		thread1.start();
		thread2.start();
//		thread2.run();
//		thread1.run();

		System.out.println("Main thread waiting for completion...");
		try {
			thread1.join(); // Wait for thread1 to finish
			thread2.join(); // Wait for thread2 to finish
		} catch (InterruptedException e) {
			System.out.println("Thread interrupted: " + e.getMessage());
		}
		System.out.println("All threads completed.");
	}
}

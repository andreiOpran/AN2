package L9;

public class E4 {
	private static int counter = 0;

	public static class CounterThread extends Thread {
		private final boolean useSync;
		private final int iterations;

		public CounterThread(boolean useSync, int iterations) {
			this.useSync = useSync;
			this.iterations = iterations;
		}

		@Override
		public void run() {
			if (useSync) {
				synchronized (E4.class) {
					for (int i = 0; i < iterations; i++) {
						counter++;
					}
				}
			} else {
				for (int i = 0; i < iterations; i++) {
					counter++;
				}
			}
		}
	}

	public static void main(String[] args) {
		System.out.println("No synchronization:");
		counter = 0;

		CounterThread thread1 = new CounterThread(false, 10000);
		CounterThread thread2 = new CounterThread(false, 10000);

		thread1.start();
		thread2.start();

		try {
			thread1.join();
			thread2.join();
		} catch (InterruptedException e) {
			System.out.println("Thread interrupted: " + e.getMessage());
		}

		System.out.println("Expected counter value: 20000");
		System.out.println("Counter value without synchronization: " + counter);

		System.out.println("\nWith synchronization:");
		counter = 0;

		thread1 = new CounterThread(true, 10000);
		thread2 = new CounterThread(true, 10000);

		thread1.start();
		thread2.start();

		try {
			thread1.join();
			thread2.join();
		} catch (InterruptedException e) {
			System.out.println("Thread interrupted: " + e.getMessage());
		}

		System.out.println("Expected counter value: 20000");
		System.out.println("Counter value with synchronization: " + counter);
	}
}

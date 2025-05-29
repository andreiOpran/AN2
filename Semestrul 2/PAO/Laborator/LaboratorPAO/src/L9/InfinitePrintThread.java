package L9;

public class InfinitePrintThread extends Thread {

	@Override
	public void run() {
		long count = 0;
		try {
			while (!isInterrupted()) {
				System.out.println("Count: " + ++count);
				Thread.sleep(1000); // Sleep for 1 second
			}
		} catch (InterruptedException e) {
			return;
		}
		System.out.println("Thread terminated gracefully.");
	}
}

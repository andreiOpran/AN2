package L9;


public class MyThread extends Thread {
	private char character;

	public MyThread(char character) {
		this.character = character;
	}

	@Override
	public void run() {
		for (int i = 0; i < 100; i++) {
			System.out.println(character);
			try {
				Thread.sleep(50);
			} catch (InterruptedException e) {
				System.out.println("Thread interrupted: " + e.getMessage());
			}
		}
	}
}
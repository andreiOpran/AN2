package L4;

public class ColorPrinter extends Printer {
	@Override
	public void print(String s) {
		System.out.println("Printing in red: " + s);
	}
	@Override
	public void print(int i) {
		System.out.println("Printing in red: " + i);
	}
}

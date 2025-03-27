package L4;

public class MathUtil {

	public int multiply(int a, int b) {
		return a * b;
	}

	public double multiply(double a, double b, double c) {
		return a * b * c;
	}

	public double multiply(int[] values) {
		int result = 1;
		for (int x : values) {
			result *= x;
		}
		return result;
	}

}

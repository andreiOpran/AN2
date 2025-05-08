package L7;

public class E4 {
	public static void main(String[] args) {
		Operatie adunare = new Operatie() {
			@Override
			public double calculeaza(double a, double b) {
				return a + b;
			}
		};

		Operatie scadere = new Operatie() {
			@Override
			public double calculeaza(double a, double b) {
				return a - b;
			}
		};

		double x = 15.5;
		double y = 5.4;

		System.out.println(adunare.calculeaza(x, y));
		System.out.println(scadere.calculeaza(x, y));
	}
}

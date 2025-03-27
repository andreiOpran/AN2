package L4;

import java.util.Comparator;

public abstract class Shape {
	abstract double getArea();

	public static final Comparator<Shape> compareByArea = new Comparator<Shape>() {
		@Override
		public int compare(Shape s1, Shape s2) {
			return Double.compare(s1.getArea(), s2.getArea());
		}
	};
}


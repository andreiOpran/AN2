package L5;

public final class ImmutablePoint {
	private final double x;
	private final double y;

	public ImmutablePoint(double x, double y) {
		this.x = x;
		this.y = y;
	}

	public double getY() {
		return y;
	}
	public double getX() {
		return x;
	}
}

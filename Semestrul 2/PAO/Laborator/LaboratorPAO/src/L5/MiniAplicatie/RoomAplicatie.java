package L5.MiniAplicatie;

public class RoomAplicatie {
	double width;
	double length;

	public RoomAplicatie(double width, double length) {
		this.width = width;
		this.length = length;
	}
	public RoomAplicatie(RoomAplicatie obj) {
		this.width = obj.width;
		this.length = obj.length;
	}

	public double getWidth() {
		return width;
	}
	public void setWidth(double width) {
		this.width = width;
	}

	public double getLength() {
		return length;
	}
	public void setLength(double length) {
		this.length = length;
	}

	@Override
	public String toString() {
		return "Room{" +
				"width=" + width +
				", length=" + length +
				'}';
	}
}

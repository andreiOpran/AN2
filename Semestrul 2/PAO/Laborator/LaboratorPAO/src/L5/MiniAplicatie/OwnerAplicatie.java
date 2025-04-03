package L5.MiniAplicatie;

public class OwnerAplicatie {
	String name;

	public OwnerAplicatie(String name) {
		this.name = name;
	}
	public OwnerAplicatie(OwnerAplicatie obj) {
		this.name = obj.name;
	}

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	@Override
	public String toString() {
		return "Owner{" +
				"name='" + name + '\'' +
				'}';
	}
}

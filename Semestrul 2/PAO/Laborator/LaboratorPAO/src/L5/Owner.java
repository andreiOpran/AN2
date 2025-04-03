package L5;

public class Owner {
	String name;

	public Owner(String name) {
		this.name = name;
	}
	public Owner(Owner obj) {
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

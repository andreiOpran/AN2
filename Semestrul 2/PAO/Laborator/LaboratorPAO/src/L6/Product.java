package L6;

public class Product {

	public Product(String name, double price) {
		this.name = name;
		this.price = price;
	}

	static int numberOfProducts = 0;
	int id;
	String name;

	@Override
	public String toString() {
		return "Product{" +
				"id=" + id +
				", name='" + name + '\'' +
				", price=" + price +
				'}';
	}

	double price;

	{
		id = ++numberOfProducts;
	}
}

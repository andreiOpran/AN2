package L5;

public class Main {
	public static void main(String[] args) {
		Room room1 = new Room(1, 2);
		Owner owner1 = new Owner("John 1");
		House house1 = new House("Address 1", room1, owner1);
		System.out.println(house1.toString());
		room1.setLength(3);
		room1.setWidth(4);
		owner1.setName("John 2");
		System.out.println(house1.toString());

		System.out.println();
		Person person1 = new Person("John", 25);
		Person copy1Person1 = new Person("John", 25);
		Person copy2Person1 = new Person(person1);
		System.out.println(person1.equals(copy1Person1)); // true
		System.out.println(person1.hashCode());
		System.out.println(copy1Person1.hashCode());
		System.out.println(copy2Person1.hashCode());
		System.out.println(person1.equals(copy2Person1)); // true
		System.out.println(person1.equals(new Person("John", 30))); // false

		System.out.println();
		ImmutablePoint point1 = new ImmutablePoint(1, 2);
//		ImmutablePoint.x = 3; // Error: cannot assign a value to final variable x
		point1 = new ImmutablePoint(3, 4); // This is allowed because we are creating a new object

		System.out.println();
		String s = "abc";
		System.out.println(s);
		s.toUpperCase();
		System.out.println(s); // String is immutable, so the original string remains unchanged
		s = s.toUpperCase(); // This creates a new string object
		System.out.println(s); // Now s points to the new string object
		StringBuilder sb = new StringBuilder("abc");
		System.out.println(sb);
		sb.append("def");
		System.out.println(sb);
		sb.insert(2, "xyz");
		System.out.println(sb);
		sb.delete(4, 7);
		System.out.println(sb);

		Student student1 = new Student("John1", 242, 9.5);
		Student student2 = new Student("John2", 243, 9.2);
		System.out.println(student1.toString());
		System.out.println(student2.toString());
		System.out.println(student1.equals(student2)); // false
		System.out.println(student1.name());
	}
}

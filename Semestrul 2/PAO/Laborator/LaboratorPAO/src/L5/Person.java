package L5;

import java.util.Objects;

public class Person {
	String name;
	int age;

	@Override
	public boolean equals(Object o) {
		if (o == null || getClass() != o.getClass()) return false;
		Person person = (Person) o;
		return age == person.age && Objects.equals(name, person.name);
	}

	@Override
	public int hashCode() {
		return Objects.hash(name, age);
	}

	@Override
	public String toString() {
		return "Person{" +
				"name='" + name + '\'' +
				", age=" + age +
				'}';
	}

	public Person(String name, int age) {
		this.name = name;
		this.age = age;
	}

	public Person(Person person) {
		this.name = person.name;
		this.age = person.age;
	}
}

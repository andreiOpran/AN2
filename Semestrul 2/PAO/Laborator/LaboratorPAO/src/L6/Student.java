package L6;

public class Student implements Comparable<Student> {

	String nume;
	Double medie;

	public Student(String nume, Double medie) {
		this.nume = nume;
		this.medie = medie;
	}

	@Override
	public String toString() {
		return "Student{" +
				"nume='" + nume + '\'' +
				", medie=" + medie +
				'}';
	}

	@Override
	public int compareTo(Student other) {
		if (this.medie < other.medie)
			return -1;
		else if (this.medie > other.medie)
			return 1;
		else
			return this.nume.compareTo(other.nume);
	}
}

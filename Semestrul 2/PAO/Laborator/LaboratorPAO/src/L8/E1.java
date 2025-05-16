package L8;

import java.util.*;

public class E1 {
	public static void main(String[] args) {
		ArrayList<Student> 	students = new ArrayList<>();
		Student student1 = new Student("Popescu", 1, 9.5f);
		Student student2 = new Student("Ionescu", 2, 7.5);
		Student student3 = new Student("Vasile", 1, 7.5);
		Student student4 = new Student("Georgescu", 2, 7.5);
		Student student5 = new Student("Marin", 1, 10.0);
		Student student6 = new Student("Dumitrescu", 2, 9.0);

		students.add(student1);
		students.add(student2);
		students.add(student3);
		students.add(student4);
		students.add(student5);
		students.add(student6);
		Collections.sort(students, new Comparator<Student>() {
			@Override
			public int compare(Student s1, Student s2) {
				return Double.compare(s1.medie, s2.medie);
			}
		});
		System.out.println("Studentii sortati dupa medie descrescator: ");
		for (Student student : students) {
			System.out.println(student.getNume() + ' ' + student.getGrupa() + ' ' + student.getMedie());
		}
		System.out.println("Studentul cu cea mai mare medie: " + students.get(0).getNume() + ' ' + students.get(0).getGrupa() + ' ' + students.get(0).getMedie());

		Scanner scanner = new Scanner(System.in);
		System.out.println("Introdu prima litera a numelui pe care doresti sa il cauti: ");
		String litera = scanner.nextLine();
		System.out.println("Studentii care incep cu litera " + litera + ": ");
		boolean found = false;
		for (Student student : students) {
			if (student.getNume().startsWith(litera) || student.getNume().startsWith(litera.toUpperCase())) {
				System.out.println(student.getNume() + ' ' + student.getGrupa() + ' ' + student.getMedie());
				found = true;
			}
		}
		if (!found) {
			System.out.println("Nu exista studenti care incep cu litera " + litera);
		}
	}
}

package L3;

import java.util.ArrayList;
import java.util.Arrays;

public class GestionareStudenti {

	public static void main(String[] args) {
		Manager manager = Manager.getInstance();

		Student student1 = new Student("Ion", 20, 9.5);
		Student student2 = new Student("Ana", 21, 9.8);
		Student student3 = new Student("Vasile", 22, 9.3);
		Student student4 = new Student("Maria", 23, 9.7);
		Student student5 = new Student("George", 24, 9.6);
		Student student6 = new Student("Elena", 25, 9.4);
		Student student7 = new Student("Mihai", 26, 9.9);
		Student student8 = new Student("Diana", 27, 9.2);
		Student student9 = new Student("Alex", 28, 9.1);
		Student student10 = new Student("Andreea", 29, 9.0);

		manager.adaugaStudent(student1);
		manager.adaugaStudent(student2);
		manager.adaugaStudent(student3);
		manager.adaugaStudent(student4);
		manager.adaugaStudent(student5);
		manager.adaugaStudent(student6);
		manager.adaugaStudent(student7);
		manager.adaugaStudent(student8);
		manager.adaugaStudent(student9);
		manager.adaugaStudent(student10);

		manager.afisareStudenti();
		System.out.println();
		manager.modificareStudent(0, "Ionel", 0, 4.9);
		manager.afisareStudenti();
	}

	public void afisareStudenti(ArrayList<Student> studenti) {
		for (Student student : studenti) {
			System.out.println(student.getNume() + " " + student.getVarsta() + " " + student.getMedie());
		}
	}

	public void adaugaStudent(ArrayList<Student> studenti, Student student) {
		studenti.add(student);
	}

	public void modificareStudent(ArrayList<Student> studenti, int index, String nume, int varsta, double medie) {
		Student student = studenti.get(index);
		if (nume != null) student.setNume(nume);
		if (varsta != 0) student.setVarsta(varsta);
		if (medie != 0) student.setMedie(medie);
	}

	public void sorteazaStudenti(ArrayList<Student> studenti) {
		studenti.sort(Student::compareTo);
	}

	public void cautareStudentMedie(ArrayList<Student> studenti, double medie) {
		Student[] studentiArray = studenti.toArray(new Student[0]);
		Arrays.sort(studentiArray);
		Student target = new Student("", 0, medie);
		int index = Arrays.binarySearch(studentiArray, target);
		if (index >= 0) {
			Student student = studentiArray[index];
			System.out.println(student.getNume() + " " + student.getVarsta() + " " + student.getMedie());
		}
		else {
			System.out.println("Studentul cu media " + medie + " nu a fost gasit.");
		}

	}

}

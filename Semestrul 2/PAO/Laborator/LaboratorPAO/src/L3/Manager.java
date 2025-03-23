package L3;

import java.util.ArrayList;

public class Manager {
	private static Manager instance = null;
	private final ArrayList<Student> studenti;

	private Manager() {
		studenti = new ArrayList<>();
	}

	public static Manager getInstance() {
		if (instance == null) {
			instance = new Manager();
		}
		return instance;
	}

	public void afisareStudenti() {
		for (Student student : this.studenti) {
			System.out.println(student.getNume() + " " + student.getVarsta() + " " + student.getMedie());
		}
	}

	public void adaugaStudent(Student student) {
		this.studenti.add(student);
	}

	public void modificareStudent(int index, String nume, int varsta, double medie) {
		Student student = studenti.get(index);
		if (nume != null) student.setNume(nume);
		if (varsta != 0) student.setVarsta(varsta);
		if (medie != 0) student.setMedie(medie);
	}
}

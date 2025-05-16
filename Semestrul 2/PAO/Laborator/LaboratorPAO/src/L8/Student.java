package L8;

public class Student {
	String nume;
	int grupa;
	Double medie;

	public Student(String nume, int grupa, double medie) {
		this.nume = nume;
		this.grupa = grupa;
		this.medie = medie;
	}

	public String getNume() {
		return nume;
	}

	public int getGrupa() {
		return grupa;
	}

	public Double getMedie() {
		return medie;
	}

	public void setNume(String nume) {
		this.nume = nume;
	}

	public void setGrupa(int grupa) {
		this.grupa = grupa;
	}

	public void setMedie(Double medie) {
		this.medie = medie;
	}
}

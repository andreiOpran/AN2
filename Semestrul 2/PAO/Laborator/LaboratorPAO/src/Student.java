public class Student {
	private String nume;
	private int varsta;
	private double medie;

	public Student() {
		this.nume = "Necunoscut";
		this.varsta = 0;
		this.medie = 0;
	}
	public Student(String nume, int varsta, double medie) {
		this.nume = nume;
		this.varsta = varsta;
		this.medie = medie;
	}

	public String getNume() {
		return nume;
	}
	public void setNume(String nume) {
		this.nume = nume;
	}

	public int getVarsta() {
		return varsta;
	}
	public void setVarsta(int varsta) {
		this.varsta = varsta;
	}

	public double getMedie() {
		return medie;
	}
	public void setMedie(double medie) {
		this.medie = medie;
	}
}

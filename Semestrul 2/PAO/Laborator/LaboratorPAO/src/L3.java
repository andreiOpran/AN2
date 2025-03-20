import java.util.Arrays;

public class L3 {

	public static class Persoana {
		private String nume;
		private int varsta;
		private double[] venit; // veniturile pe 12 luni
		private static int nrPersoana; // pentru contorizarea instantelor
		private int id; // id-ul unic al fiecarei instante

		public Persoana() {
			this.nume = "Necunoscut";
			this.varsta = 0;
			this.venit = new double[12];
		}

		public Persoana(String nume, int varsta, double[] venit) {
			this.nume = nume;
			this.varsta = varsta;
			this.venit = venit;
			this.id = nrPersoana;
		}

		public Persoana(Persoana obj) {
			this.nume = obj.nume;
			this.varsta = obj.varsta;
			this.venit = obj.venit.clone(); // deep copy
		}

		public String PersoanaToString() {
			return "Persoana cu id-ul " + id + ":\n" +
				   "Nume: " + nume + "\n" +
				   "Varsta: " + varsta + "\n" +
				   "Venit: " + Arrays.toString(venit) + "\n";
		}

		public String getNume() {
			return nume;
		}
		public void setNumet(String nume) {
			this.nume = nume;
		}

		public int getVarsta() {
			return varsta;
		}
		public void setVarsta(int varsta) {
			this.varsta = varsta;
		}

		public double[] getVenit() {
			return venit;
		}
		public void setVenit(double[] venit) {
			this.venit = venit;
		}

		static {
			nrPersoana = 0;
			System.out.println("\nClasa Persoana a fost incarcata.\n");
		}

		{
			this.id = ++nrPersoana;
			System.out.println("Instanta a fost creata cu id-ul " + id + ".");
		}

	}

	public static void main(String[] args) {

		Persoana p1 = new Persoana();
		System.out.println(p1.PersoanaToString());

		Persoana p2 = new Persoana("Ion", 30, new double[]{1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10000, 11000, 12000});
		System.out.println(p2.PersoanaToString());

	}

}


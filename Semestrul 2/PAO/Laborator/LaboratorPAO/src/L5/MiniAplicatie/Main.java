package L5.MiniAplicatie;

public class Main {
    public static void main(String[] args) {
		OwnerAplicatie owner1 = new OwnerAplicatie("John Doe");
		House house1 = new House("Bucuresti", "Strada 1", new RoomAplicatie(2, 3), owner1);
		Student student1 = new Student("John1", 242, 9.5);
		Student student2 = new Student("John2", 243, 9.2);

		StringBuilder sbHouse;
		sbHouse = new StringBuilder();
		sbHouse.append("Adresa casei: ").append(house1.getAdress()).append(", ").append("\n");
		sbHouse.append("Proprietar: ").append(house1.getOwnerAplicatie()).append(", ").append("\n");
		System.out.println(sbHouse);

		StringBuilder sbStudent;
		sbStudent = new StringBuilder();
		sbStudent.append("Student 1: ").append(student1.toString()).append(", ").append("\n");
		sbStudent.append("Student 2: ").append(student2.toString()).append(", ").append("\n");
		System.out.println(sbStudent);
	}
}
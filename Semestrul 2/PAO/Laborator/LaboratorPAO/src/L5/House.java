package L5;

public class House {
	String adress;
	Room diningRoom;
	Owner owner;

	public House(String adress, Room diningRoom, Owner owner) {
		this.adress = adress;
		this.diningRoom = new Room(diningRoom); // compozitie (initializeaza o copie)
		this.owner = owner; // agregare (stocheaza referinta directa)
	}

	@Override
	public String toString() {
		return "House{" +
				"adress='" + adress + '\'' +
				", diningRoom=" + diningRoom +
				", owner=" + owner +
				'}';
	}
}

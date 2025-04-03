package L5.MiniAplicatie;

import L5.Owner;
import L5.Room;

public class House {
	Address adress;
	RoomAplicatie diningRoom;
	OwnerAplicatie owner;

	public House(String city, String street, RoomAplicatie diningRoom, OwnerAplicatie owner) {
		this.adress = new Address(city, street); // imutabilitate (initializeaza o copie)
		this.diningRoom = new RoomAplicatie(diningRoom); // compozitie (initializeaza o copie)
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

	public Address getAdress() {
		return adress;
	}
	public OwnerAplicatie getOwnerAplicatie() {
		return owner;
	}

}

package L7;

import java.io.IOException;
import java.io.RandomAccessFile;
import java.util.Random;

public class E3 {
	public static void main(String[] args) {
		String outputFile = "src/L7/e3.bin";

		try (RandomAccessFile accessFile = new RandomAccessFile(outputFile, "rw")) {
			Random random = new Random();
			double randomDouble;

			int i = 0;
			while (i++ < 10) {
				randomDouble = random.nextDouble() * 10;
				accessFile.writeDouble(randomDouble);
			}

			System.out.println("\nAll values before modification:");
			accessFile.seek(0);
			for (int j = 0; j < 10; j++) {
				try {
					double value = accessFile.readDouble();
					System.out.println("Value " + (j + 1) + ": " + value);
				} catch (IOException e) {
					System.out.println("End of file reached after " + j + " values.");
					break;
				}
			}

			accessFile.seek(4); // seek to byte 5
			byte fifthByte = accessFile.readByte();
			System.out.println("5th byte: " + fifthByte);
			System.out.println();

			accessFile.seek(3); // seek to byte 4
			byte fourthByte = accessFile.readByte();
			System.out.println("Original value for 4th byte: " + fourthByte);
			byte newValue = (byte) (fourthByte * 2);
			accessFile.seek(3);
			accessFile.writeByte(newValue);
			System.out.println("New value for 4th byte: " + newValue);

			System.out.println("\nAll values after modification:");
			accessFile.seek(0);
			for (int j = 0; j < 10; j++) {
				try {
					double value = accessFile.readDouble();
					System.out.println("Value " + (j + 1) + ": " + value);
				} catch (IOException e) {
					System.out.println("End of file reached after " + j + " values.");
					break;
				}
			}

		} catch (IOException e) {
			System.err.println("Error processing files: " + e.getMessage());
			e.printStackTrace();
		}
	}
}

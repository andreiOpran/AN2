package L7;

import org.jetbrains.annotations.NotNull;

import java.io.*;

public class E1 {
	public static void main(String[] args) {
		String inputFile = "src/L7/e1.txt";
		String outputFile = "src/L7/e1_copy.txt";
		int characterCount = 0;

		try (FileReader reader = new FileReader(inputFile);
			 FileWriter writer = new FileWriter(outputFile)) {

			int character;
			while ((character = reader.read()) != -1) {
				writer.write(character);
				characterCount++;
			}

			System.out.println("Total characters copied: " + characterCount);

		} catch (IOException e) {
			System.err.println("Error processing files: " + e.getMessage());
			e.printStackTrace();
		}
	}
}

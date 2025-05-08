package L7;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

public class E2 {
	public static void main(String[] args) {
		String inputFile = "src/L7/e2.bmp";
		String outputFile = "src/L7/e2_inverted.bmp";

		try (FileInputStream reader = new FileInputStream(inputFile);
			 FileOutputStream writer = new FileOutputStream(outputFile)) {

			byte oneByte;
			int byteCount = 0;
			while ((oneByte = (byte) reader.read()) != -1) {
				if (byteCount < 54) {
					writer.write(oneByte);
				} else {
					writer.write((255 - oneByte));
				}
				byteCount++;
			}

		} catch (IOException e) {
			System.err.println("Error processing files: " + e.getMessage());
			e.printStackTrace();
		}
	}
}

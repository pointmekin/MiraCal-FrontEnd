import java.util.Scanner;
import java.io.File;
import java.io.FileNotFoundException;

public class ExtractDB {
    public static void main(String[] args) {
        try {
            Scanner fileScanner = new Scanner(new File("Dessert test.xlsx"));
            fileScanner.useDelimiter("[,\n]");
            fileScanner.nextLine();
            System.out.print("[");

            while (fileScanner.hasNext()) {
                System.out.print(",[");
                for(int i = 0;i<3;i++){
                    System.out.print(fileScanner.next() + ",");
                }
                fileScanner.next();
                System.out.print("]");
            }

            System.out.print("]");
        }catch (FileNotFoundException e) {
            System.out.println("Error: File not found!");
        }
    }
}
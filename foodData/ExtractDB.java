import java.util.Scanner;
import java.io.File;
import java.io.FileNotFoundException;

public class ExtractDB {
    public static void main(String[] args) {

        System.out.println("ไทย");

        try {
            Scanner fileScanner = new Scanner(new File("Dessert test2.csv"));
            fileScanner.useDelimiter("[,\n]");
            fileScanner.nextLine();
            System.out.println("[");

            while (fileScanner.hasNext()) {
                System.out.print(",[");
                for(int i = 0;i<3;i++){
                    System.out.println(fileScanner.next() + ",");
                }
                //fileScanner.next();
                System.out.println("]");
            }

            System.out.println("]");
        }catch (FileNotFoundException e) {
            System.out.println("Error: File not found!");
        }
    }
}
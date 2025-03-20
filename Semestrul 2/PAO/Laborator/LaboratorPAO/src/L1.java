public class L1 {
    public static void main(String[] args) {

//        // String text = "Hello, World!";
//        Scanner scanner = new Scanner(System.in);
//
//        int a =  scanner.nextInt();
//        System.out.println(a);
//        scanner.nextLine();
//        String text = scanner.nextLine();
//        System.out.println(text);
//
//        System.out.printf("Hello, %s!\n", "broski");
//        // %s - string
//        // %d - integer
//        // %f - float
//        // %c - char
//        // %b - boolean
//        // %n - new line
//        // %t - date/time
//        // %x - hexadecimal
//        // %e - scientific notation


        int[] integers = new int[5]; // {0, 0, 0, 0, 0}
        int[] integers2 = new int[]{1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
//        integers[0] = 1;
//        integers[1] = 2;
//        integers[2] = 3;
//        integers[3] = 4;
//        integers[4] = 5;
        // System.out.println(integers);

        for (int i = 0; i < integers.length;) {
            integers[i] = ++i;
        }
        for (int x : integers) {
            System.out.println(x);
        }
        System.out.println();
        for (int i = 0; i < integers2.length; i++) {
            System.out.println(integers2[i]);
        }
    }
}
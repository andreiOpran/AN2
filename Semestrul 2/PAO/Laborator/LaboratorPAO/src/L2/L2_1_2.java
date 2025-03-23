package L2;

import java.util.Arrays;

public class L2_1_2 {
	public static void main(String[] args) {

//		int[] a, b;
//		int c[], d;
//
//		int[] t = new int[10];
//		int t2[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
//		System.out.println(Arrays.toString(t2));
//		System.out.println(t2);

		int[] v = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};

		System.out.println("Afisare elemente vector cu for normal:");
		for(int i = 0; i < v.length; ++i) {
			System.out.print(v[i] + " ");
		}
		System.out.println("\nAfisare elemente vector cu enhanced for:");
		for(int x : v) {
			System.out.print(x + " ");
		}
		System.out.println("\nAfisare elemente vector cu Arrays.toString():");
		System.out.println(Arrays.toString(v));
		System.out.println();

		int[][] mat = new int [3][];
		mat[0] = new int[]{1, 2, 3};
		mat[1] = new int[]{4, 5, 6, 7};
		mat[2] = new int[]{8, 9};

		for(int[] linie : mat) {
			for(int x : linie) {
				System.out.print(x + " ");
			}
			System.out.println();
		}
		System.out.println();
		System.out.println(Arrays.deepToString(mat));

	}
}

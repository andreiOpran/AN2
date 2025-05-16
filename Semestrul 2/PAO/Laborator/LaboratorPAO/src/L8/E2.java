package L8;

import java.util.Collections;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.ListIterator;

public class E2 {
	public static void prioritizeUrgentTasks(LinkedList<String> linkedList, String keyword) {
		LinkedList<String> keywordList = new LinkedList<>();
		for (Iterator<String> i = linkedList.iterator(); i.hasNext();) {
			String current = i.next();
			if (current.contains(keyword)) {
				i.remove(); // Remove the current element
				keywordList.addFirst(current); // Add it to the beginning of the list
			}
		}
		// Add the keywordList to the beginning of the original list
		for(String task : keywordList) {
			linkedList.addFirst(task);
		}
	}

	public static void main(String[] args) {
		LinkedList<String> taskList = new LinkedList<>();
		taskList.addLast("Last task");
		taskList.addFirst("First task");
		taskList.add(1, "Second task");

		System.out.println("Task list:");
		for (String task : taskList) {
			System.out.println(task);
		}

		System.out.println("Removing second task...");
		taskList.remove(1);

		System.out.println("Task list after removal:");
		for (String task : taskList) {
			System.out.println(task);
		}

		System.out.println("Task list in reversed order: ");
		for (Iterator<String> i = taskList.descendingIterator(); i.hasNext();) {
			System.out.println(i.next());
		}

		taskList.addLast("Urgent task 1");
		taskList.addLast("Urgent task 2");
		System.out.println("Task list before prioritizing:");
		for (String task : taskList) {
			System.out.println(task);
		}
		System.out.println("Prioritizing urgent tasks...");
		System.out.println("Keyword: urgent");
		prioritizeUrgentTasks(taskList, "Urgent");
		System.out.println("Task list after prioritizing:");
		for (String task : taskList) {
			System.out.println(task);
		}
	}
}

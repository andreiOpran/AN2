## 1. Thread Implementation
```java
public class FirmaCalculatorThread extends Thread {
    private String filePath;
    private String firma;
    private float totalValue;

    public FirmaCalculatorThread(String filePath, String firma) {
        this.filePath = filePath;
        this.firma = firma;
    }

    @Override
    public void run() {
        // Thread execution logic
    }

    public float getTotalValue() {
        return totalValue;
    }
}
```

## 2. Thread Usage
```java
FirmaCalculatorThread t1 = new FirmaCalculatorThread("file1.txt", "company");
t1.start();
t1.join();  // Wait for thread completion
```

## Key Threading Components

### Thread Class
```java
class MyThread extends Thread {
    public void run() {
        // Thread logic
    }
}
```

### Thread Methods
```java
thread.start();  // Starts thread execution
thread.join();   // Waits for thread to finish
```

### Thread Exception Handling
```java
try {
    thread.join();
} catch (InterruptedException e) {
    e.printStackTrace();
}
```


## 1. BufferedReader with FileReader
```java
try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
    String line;
    while ((line = reader.readLine()) != null) {
        // Process each line
    }
} catch (Exception e) {
    e.printStackTrace();
}
```

## 2. Scanner for User Input
```java
Scanner scanner = new Scanner(System.in);
String input = scanner.nextLine();
scanner.close();
```

## Key File I/O Components

### BufferedReader
```java
BufferedReader reader = new BufferedReader(new FileReader("file.txt"));
String line = reader.readLine();
```

### FileReader
```java
FileReader fr = new FileReader("file.txt");
```

### Scanner
```java
Scanner scanner = new Scanner(System.in);
String input = scanner.nextLine();
```

### File Parsing
```java
String[] parts = line.split(",");
float value = Float.parseFloat(parts[2]);
```

### Exception Handling
```java
try {
    // IO operations
} catch (IOException e) {
    e.printStackTrace();
}
```

### Try-with-resources
```java
try (BufferedReader br = new BufferedReader(new FileReader(file))) {
    // Automatic resource management
}
```
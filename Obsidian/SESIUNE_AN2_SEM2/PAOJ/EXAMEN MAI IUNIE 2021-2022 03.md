# I

1. b)
2. d)
3. a)
4. c)
5. c)

---

# IV

```java
class DatabaseConnection {  
    private static DatabaseConnection instance;  
    private Connection connection;  
    private static final String URL = "";  
  
    private DatabaseConnection() {  
        try {  
            this.connection = DriverManager.getConnection(URL);  
        } catch (Exception e) {  
            System.out.println(e.getMessage());  
        }  
    }  
  
    public static DatabaseConnection getInstance() {  
        if (instance == null) {  
            instance = new DatabaseConnection();  
            return instance;  
        }  
        return instance;  
    }  
  
    public Connection getConnection() {  
        return connection;  
    }  
}  
  
public class Test {  
    public static void main(String[] args) {  
        boolean afisat = false;  
        DatabaseConnection connection = DatabaseConnection.getInstance();  
        Scanner scanner = new Scanner(System.in);  
        double val_min = scanner.nextDouble();  
  
        String selectQuery = "SELECT * FROM DateAngajati WHERE SALARIU >= ?";  
        try (PreparedStatement stmt = connection.getConnection().prepareStatement(selectQuery)) {  
            stmt.setDouble(1, val_min);  
            ResultSet rs = stmt.executeQuery();  
            while (rs.next()) {  
                String CNP = rs.getString("CNP");  
                String nume = rs.getString("Nume");  
                int varsta = rs.getInt("Varsta");  
                double salariu = rs.getDouble("Salariu");  
                System.out.println(CNP + " " + nume + " " + varsta + " " + salariu);  
                afisat = true;  
            }  
  
        } catch (SQLException e) {  
            System.out.println(e.getMessage());  
        }  
        if (!afisat) {  
            System.out.println("nu exista angajati cu salariul minim precizat");  
        }  
    }  
}
```
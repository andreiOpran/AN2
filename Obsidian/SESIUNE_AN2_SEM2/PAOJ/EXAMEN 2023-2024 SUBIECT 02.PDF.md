# I

1. c)
2. d)
3. d)
4. c)
5. b)

--- 

# II

```java
imobile.stream()  
        .filter(i -> i.getNrCamere() >=3 && i.getPret() <= 500000)  
        .sorted(Comparator.comparing(Imobil::getSuprafata))  
    .forEach(System.out::println);  
  
imobile.stream()  
        .map(Imobil::getLocalitate)  
        .distinct()  
        .forEach(System.out::println);  
  
List<Imobil> newList = imobile.stream()  
        .filter(i -> i.getLocalitate().equalsIgnoreCase("Bucuresti")  
        && i.getPret() >= 300000 && i.getPret() <= 500000)  
        .toList();  
  
imobile.stream()  
        .collect(Collectors.groupingBy(Imobil::getLocalitate))  
        .forEach((l, i) -> {
	        System.out.println(l);  
            i.forEach(System.out::println);  
        });
```

---

# III

```java
  class MyThread extends Thread {  
      private String filePath;  
      private double smin;  
      private int cmin;  
      private int counter;  
  
      public MyThread(String filePath, int cmin, double smin) {  
          this.filePath = filePath;  
          this.cmin = cmin;  
          this.smin = smin;  
          this.counter = 0;  
      }  
  
      @Override  
      public void run() {  
          try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {  
              String line;  
              while ((line = reader.readLine()) != null) {  
                  String[] parts = line.split(",");  
                  String tip = parts[0];  
                  String lcoalitate = parts[1];  
                  int nrCamere = Integer.parseInt(parts[2]);  
                  double suprafata = Double.parseDouble(parts[3]);  
                  if (suprafata >= cmin && nrCamere >= cmin) {  
                      ++counter;  
                  }  
              }  
          } catch (FileNotFoundException e) {  
       throw new RuntimeException(e);  
    } catch (IOException e) {  
       throw new RuntimeException(e);  
    }  
}  
  
      public int getCounter() {  
          return counter;  
      }  
  }  
  
  public static void main(String[] args) {  
      Scanner scanner = new Scanner(System.in);  
      int cmin = scanner.nextInt();  
      double smin = scanner.nextDouble();  
  
      MyThread t1 = new MyThread("AgentieRS_1.txt", cmin, smin);  
      MyThread t2 = new MyThread("AgentieRS_2.txt", cmin, smin);  
  
      t1.start();  
      t2.start();  
  
      try {  
          t1.join();  
          t2.join();  
      } catch (InterruptedException e) {  
          System.out.println(e.getMessage());  
      }  
        
      int counter = t1.getCounter() + t2.getCounter();  
      System.out.println(counter);  
  }
```

---
# IV

```java
class Persoana {  
    String nume;  
    int varsta;  
    double salariuMediu;  
  
    public Persoana(String nume, int varsta, double salariuMediu) {  
        this.nume = nume;  
        this.varsta = varsta;  
        this.salariuMediu = salariuMediu;  
    }  
  
    @Override  
    public String toString() {  
        return "Persoana{" +  
                "nume='" + nume + '\'' +  
                ", varsta=" + varsta +  
                ", salariuMediu=" + salariuMediu +  
                '}';  
    }  
}  
  
class CitireInformatiiPersoane {  
    private static CitireInformatiiPersoane instance = null;  
    private static ArrayList<Persoana> persoane;  
    private String filePath;  
  
    private CitireInformatiiPersoane() {  
        persoane = new ArrayList<>();  
        filePath = "src/Examen/persoane.csv";  
    }  
  
    public static CitireInformatiiPersoane getInstance() {  
        if (instance == null) {  
            instance = new CitireInformatiiPersoane();  
            return instance;  
        }  
        return instance;  
    }  
  
    public void citire() {  
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {  
            String line;  
            while ((line = reader.readLine()) != null) {  
                String[] parts = line.split(",");  
                String nume = parts[0];  
                int varsta = Integer.parseInt(parts[1]);  
                double salariuMediu = Double.parseDouble((parts[2]));  
                persoane.add(new Persoana(nume, varsta, salariuMediu));  
            }  
        } catch (IOException e) {  
            System.out.println(e.getMessage());  
        }  
    }  
  
    public static ArrayList<Persoana> getPersoane() {  
        return persoane;  
    }  
}  
  
class Test {  
    public static void main(String[] args) {  
        CitireInformatiiPersoane citire = CitireInformatiiPersoane.getInstance();  
        citire.citire();  
        ArrayList<Persoana> rezultat = new ArrayList<>(citire.getPersoane());  
        for (Persoana p : rezultat) {  
            System.out.println(p);  
        }  
    }  
}
```
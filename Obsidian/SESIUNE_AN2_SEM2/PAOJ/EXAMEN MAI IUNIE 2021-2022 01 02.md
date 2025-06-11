# 01

##  I

1.  a)
2.  d)
3.  c)
4.  a)
5.  b)

---
## II

```java
imobile.stream()  
        .filter(i -> i.getNrCamere() >= 3 && i.getPret() < 100000)  
        .sorted(Comparator.comparing(Imobil::getSuprafata))  
        .forEach(System.out::println);  
  
imobile.stream()  
        .map(Imobil::getLocalitate)  
        .distinct()  
        .forEach(System.out::println);  
  
List<Imobil> colectie = imobile.stream()  
        .filter(i -> i.getLocalitate().equalsIgnoreCase("Bucuresti") && i.getPret() >= 200000 && i.getPret() < 500000)  
        .toList();  
  
imobile.stream()  
        .collect(Collectors.groupingBy(Imobil::getLocalitate))  
        .forEach((l, i) -> {  
            System.out.println(l);  
            i.forEach(System.out::println);  
        });
```

## III

```java
class MyThread extends Thread {  
    private String filePath;  
    private int counter;  
    private double smin;  
    private int cmin;  
  
    public MyThread(String filePath, double smin, int cmin) {  
        this.filePath = filePath;  
        this.counter = 0;  
        this.smin = smin;  
        this.cmin = cmin;  
    }  
  
    @Override  
    public void run() {  
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {  
            String line;  
            while ((line = reader.readLine()) != null) {  
                String[] parts = line.split(",");  
                int nrCamere = Integer.parseInt(parts[2]);  
                double suprafata = Double.parseDouble(parts[3]);  
                if (nrCamere >= cmin && suprafata >= smin) {  
                    ++counter;  
                }  
  
            }  
        } catch (IOException e) {  
            System.out.println(e.getMessage());  
        }  
    }  
  
    public int getCounter() {  
        return counter;  
    }  
}  
  
public class Test {  
    public static void main(String[] args) {  
        MyThread t1 = new MyThread("src/Examen/agentieRentSale_1.txt", 10, 5);  
        MyThread t2 = new MyThread("src/Examen/agentieRentSale_2.txt", 10, 5);  
  
        t1.start();  
        t2.start();  
  
        try {  
            t1.join();  
            t2.join();  
        } catch (InterruptedException e) {  
            System.out.println(e.getMessage());  
        }  
  
        int result = t1.getCounter() + t2.getCounter();  
        System.out.println(result);  
    }  
}
```

---

## IV

```java
class Adresa {  
    String strada;  
    int numar;  
  
    public Adresa(String strada, int numar) {  
        this.strada = strada;  
        this.numar = numar;  
    }  
  
    public String getStrada() {  
        return strada;  
    }  
  
    public void setStrada(String strada) {  
        this.strada = strada;  
    }  
  
    public int getNumar() {  
        return numar;  
    }  
  
    public void setNumar(int numar) {  
        this.numar = numar;  
    }  
}  
  
final class Firma {  
    private final String denumire;  
    private final int numarAngajati;  
    private final double profitMediuAnual;  
    private final Adresa adresa;  
  
    public Firma(String denumire, int numarAngajati, double profitMediuAnual, Adresa adresa) {  
        this.denumire = denumire;  
        this.numarAngajati = numarAngajati;  
        this.profitMediuAnual = profitMediuAnual;  
        this.adresa = new Adresa(adresa.getStrada(), adresa.getNumar());  
    }  
  
    public String getDenumire() {  
        return denumire;  
    }  
  
    public int getNumarAngajati() {  
        return numarAngajati;  
    }  
  
    public double getProfitMediuAnual() {  
        return profitMediuAnual;  
    }  
  
    public Adresa getAdresa() {  
        return new Adresa(adresa.getStrada(), adresa.getNumar());  
    }  
}
```

---

# 02

## I

1. b)
2. c)
3. d)
4. b)
5. a)

---

## II

```java
suvenirs.stream()  
        .filter(s -> s.getMaterial().equalsIgnoreCase("aur") && s.getPret() >= 100)  
        .sorted(Comparator.comparing(Suvenir::getPret))  
        .forEach(System.out::println);  
  
suvenirs.stream()  
        .map(Suvenir::getMaterial)  
        .distinct()  
        .forEach(System.out::println);  
  
List<Suvenir> lista = suvenirs.stream()  
        .filter(s -> s.getMaterial().equalsIgnoreCase("plastic") && s.getPret() >= 500 && s.getPret() <= 1000)  
        .toList();  
  
suvenirs.stream()  
        .collect(Collectors.groupingBy(Suvenir::getMaterial))  
        .forEach((m, s) -> {  
           System.out.println(m);  
           s.forEach(System.out::println);  
        });
```

---

## III

```java
class MyThread extends Thread {  
    private String filePath;  
    private String materialCautat;  
    private double valoareTotala;  
  
    public MyThread(String filePath, String materialCautat) {  
        this.filePath = filePath;  
        this.materialCautat = materialCautat;  
        this.valoareTotala = 0;  
    }  
  
    @Override  
    public void run() {  
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {  
            String line;  
            while ((line = reader.readLine()) != null) {  
                String[] parts = line.split(",");  
                String material = parts[1];  
                int cantitate = Integer.parseInt(parts[2]);  
                double pret = Double.parseDouble(parts[3]);  
                if (material.equalsIgnoreCase(materialCautat)) {  
                    valoareTotala += cantitate * pret;  
                }  
            }  
        } catch (IOException e) {  
            System.out.println(e.getMessage());  
        }  
    }  
  
    public double getValoareTotala() {  
        return valoareTotala;  
    }  
}  
  
public class Test {  
    public static void main(String[] args) {  
        MyThread t1 = new MyThread("src/Examen/stoisko_1.txt", "plastic");  
        MyThread t2 = new MyThread("src/Examen/stoisko_2.txt", "plastic");  
  
        t1.start();  
        t2.start();  
  
        try {  
            t1.join();  
            t2.join();  
        } catch (InterruptedException e) {  
            System.out.println(e.getMessage());  
        }  
  
        double valoareTotala = t1.getValoareTotala() + t2.getValoareTotala();  
        System.out.println(valoareTotala);  
    }  
}
```

---

## IV

```java
class CitireScrierePersoane {  
    private static CitireScrierePersoane instance;  
    private String filePath;  
    private List<Persoana> persoane;  
  
    private CitireScrierePersoane(String filePath, ArrayList<Persoana> persoane) {  
        this.filePath = filePath;  
        this.persoane = persoane;  
    }  
  
    public static CitireScrierePersoane getInstance(String filePath, ArrayList<Persoana> persoane) {  
        if (instance == null) {  
            instance = new CitireScrierePersoane(filePath, persoane);  
            return instance;  
        }  
        return instance;  
    }  
  
    public static void deleteInstance() {  
        if (instance != null) {  
            instance = null;  
        }  
    }  
  
    public void citire() {  
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {  
            String line;  
            while ((line = reader.readLine()) != null) {  
                String[] parts = line.split(",");  
                String nume = parts[0];  
                int varsta = Integer.parseInt(parts[1]);  
                double salariu = Double.parseDouble(parts[2]);  
                persoane.add(new Persoana(nume, varsta, salariu));  
            }  
        } catch (IOException e) {  
            System.out.println(e.getMessage());  
        }  
    }  
  
    public void scriere() {  
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {  
            for (Persoana persoana : persoane) {  
                String line = persoana.getNume() + ',' + persoana.getVarsta() + ',' + persoana.getSalariuMediuAnual() + '\n';  
                writer.write(line);  
            }  
        } catch (IOException e) {  
            System.out.println(e.getMessage());  
        }  
    }  
}  
  
public class Test {  
    public static void main(String[] args) {  
        ArrayList<Persoana> persoane = new ArrayList<>();  
        CitireScrierePersoane citire = CitireScrierePersoane.getInstance("src/Examen/persoane_citire.csv", persoane);  
        citire.citire();  
        CitireScrierePersoane.deleteInstance();  
  
        CitireScrierePersoane scriere = CitireScrierePersoane.getInstance("src/Examen/persoane_scriere.csv", persoane);  
        scriere.scriere();  
    }  
}
```

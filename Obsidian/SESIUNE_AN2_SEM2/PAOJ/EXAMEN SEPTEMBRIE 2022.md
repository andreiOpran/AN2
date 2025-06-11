# I

1. d)
2. c)
3. a)
4. gresit
5. a)

--- 

## II

```java
produse.stream()  
        .filter(p -> p.getDenumire().startsWith("A"))  
        .sorted(Comparator.comparing(ProdusAlimentar::getPretUnitar))  
        .forEach(System.out::println);  
  
List<ProdusAlimentar> colectie = produse.stream()  
        .filter(p -> p.getPretUnitar() >= 100 && p.getPretUnitar() <= 1000)  
        .toList();  
  
double incasariTotale = produse.stream()  
        .mapToDouble(p -> p.getPretUnitar() * p.getCantitate())  
        .sum();  
  
produse.stream()  
        .collect(Collectors.groupingBy(p -> p.getDataExpirare().substring(3)))  
        .forEach((luna, produs) -> {  
            System.out.println(luna);  
            produs.forEach(System.out::println);  
        });
```

--- 

# III

```java
class MyThread extends Thread {
    private String filePath;
    private double pmin;
    private String lexp; // care for expira in luna lexp
    private double valoareaTotala;

    public MyThread(String filePath, double pmin, String lexp) {
        this.filePath = filePath;
        this.pmin = pmin;
        this.lexp = lexp;
        this.valoareaTotala = 0;
    }

    @Override
    public void run() {
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                String dataExpirare = parts[3];
                int cantitate = Integer.parseInt(parts[1]);
                double pretUnitar = Double.parseDouble(parts[2]);

                if (dataExpirare.substring(3).equalsIgnoreCase(lexp) && pretUnitar >= pmin) {
                    valoareaTotala += pretUnitar * cantitate;
                }
            }
        } catch (IOException e) {
            System.out.println(e.getMessage());
        }
    }

    public double getValoareaTotala() {
        return valoareaTotala;
    }
}

public class Test {
    public static void main(String[] args) {
        MyThread t1 = new MyThread("produse1.txt", 100, "06-2025");
        MyThread t2 = new MyThread("produse2.txt", 100, "06-2025");

        t1.start();
        t2.start();

        try {
            t1.join();
            t2.join();
        } catch (InterruptedException e) {
            System.out.println(e.getMessage());
        }

        double valoareaToala = t2.getValoareaTotala() + t2.getValoareaTotala();
        System.out.println(valoareaToala);
    }
}
```

---

# IV

```java
final class Angajat {  
    private final Adresa adresa;  
    private String nume;  
    private int varsta;  
    private double venit;  
  
    public Angajat(Adresa adresa, String nume, int varsta, double venit) {  
        this.adresa = new Adresa(adresa.getStrada(), adresa.getNumar());  
        this.nume = nume;  
        this.varsta = varsta;  
        this.venit = venit;  
    }  
  
    public Adresa getAdresa() {  
        return new Adresa(adresa.getStrada(), adresa.getNumar());  
    }  
  
    public String getNume() {  
        return nume;  
    }  
  
    public int getVarsta() {  
        return varsta;  
    }  
  
    public double getVenit() {  
        return venit;  
    }  
}
```
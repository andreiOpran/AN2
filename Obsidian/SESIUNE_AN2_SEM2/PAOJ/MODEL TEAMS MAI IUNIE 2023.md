# I

1. a)
2. c) metodele statice sunt chemate dupa tipul referintei
	   metodele nestatice sunt chemate dupa tipul obiectului
3.  d)
4.  b)
5.  c)

--- 

# II

```java
automobile.stream()  
		.filter(a -> a.getPret() <= 7000)  
		.sorted(Comparator.comparing(Automobil::getPret))  
		.forEach(System.out::println);  

automobile.stream()  
		.map(Automobil::getMarca)  
		.distinct()  
		.sorted()  
		.forEach(System.out::println);  

List<Automobil> newList = automobile.stream()  
		.filter(a -> a.getCapacitate() >= 1000 && a.getCapacitate() <= 2000)  
		.toList();  

automobile.stream()  
		.filter(a -> a.getMarca().equals("BMW"))  
		.mapToDouble(Automobil::getPret)  
		.min()  
		.ifPresent(System.out::println);  
```

---

# III

```java
class MyThread extends Thread {  
    private String filePath;  
    private int counter;  
  
    public MyThread(String filePath) {  
        this.filePath = filePath;  
        this.counter = 0;  
    }  
  
    @Override  
    public void run() {  
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {  
            String line;  
            while ((line = reader.readLine()) != null) {  
                String[] parts = line.split("[,.?! /;]+");  
                counter += parts.length;  
            }  
  
        } catch (IOException e) {  
            System.out.println(e.getMessage());  
        }  
    }  
  
    public int getCounter() {  
        return counter;  
    }  
}  
  
class Test {  
    public static void main(String[] args) {  
        MyThread t1 = new MyThread("src/Examen/f1.txt");  
        MyThread t2 = new MyThread("src/Examen/f2.txt");  
  
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
}
```

---

# IV

```java
class Angajat {  
    String nume;  
    int vechime;  
    double salariu;  
  
    public Angajat(String nume, int vechime, double salariu) {  
        this.nume = nume;  
        this.vechime = vechime;  
        this.salariu = salariu;  
    }  
  
    public String getNume() {  
        return nume;  
    }  
  
    public void setNume(String nume) {  
        this.nume = nume;  
    }  
  
    public double getSalariu() {  
        return salariu;  
    }  
  
    public void setSalariu(double salariu) {  
        this.salariu = salariu;  
    }  
  
    public int getVechime() {  
        return vechime;  
    }  
  
    public void setVechime(int vechime) {  
        this.vechime = vechime;  
    }  
  
    @Override  
    public boolean equals(Object o) {  
        if (o == null || getClass() != o.getClass()) return false;  
        Angajat angajat = (Angajat) o;  
        return vechime == angajat.vechime && Double.compare(salariu, angajat.salariu) == 0 && Objects.equals(nume, angajat.nume);  
    }  
  
    @Override  
    public int hashCode() {  
        return Objects.hash(nume, vechime, salariu);  
    }  
}  
  
interface CalculImpozit {  
    double calculeaza(int vechime, double salariu);  
}  
  
class CalculImpozitMaxim {  
    static double getImpozitMaxim(List<Angajat> angajati, CalculImpozit formula) {  
        return angajati.stream()  
                .mapToDouble(angajat-> formula.calculeaza(angajat.getVechime(), angajat.getSalariu()))  
                .max()  
                .orElse(0);  
    }  
}  
  
/*  
class CalculImpozitMaxim {  
    public static double calculeazaImpozit(List<Angajat> lista, CalculImpozit formula) {        double max = 0.0;        for(Angajat a: lista) {            double impozit = formula.calculeaza(a.getVechime(), a.getSalariu());            if(impozit > max) {                max = impozit;            }        }        return max;    }}  
*/  
  
public class Test {  
  
    public static void main(String[] args) {  
        List<Angajat> angajati = new ArrayList<>();  
        angajati.add(new Angajat("Ion Popescu", 5, 5000));  
        angajati.add(new Angajat("Maria Ionescu", 10, 7000));  
        angajati.add(new Angajat("George Marinescu", 2, 3500));  
  
        CalculImpozit calculImpozit = (vechime, salariu) -> {  
            double procent = vechime > 5 ? 0.2 : 0.1;  
            return salariu * procent;  
        };  
  
        double impozitMaxim = CalculImpozitMaxim.getImpozitMaxim(angajati, calculImpozit);  
        System.out.println(impozitMaxim);  
    }  
}
```
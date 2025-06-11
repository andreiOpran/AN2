# Java Stream API - Detailed Explanation

## Basic Stream Operations

### 1. Creating Streams
- From Collections: `collection.stream()`
- From Arrays: `Arrays.stream(array)`
- From values: `Stream.of(val1, val2, val3)`
- From files: `Files.lines(path)`

### 2. Filtering (Intermediate Operation)
```java
.filter(predicate)
```
Keeps only elements that match the given condition.

Example from your code:
```java
.filter(p -> p.getPretUnitar() >= 100)
```
Keeps only products with unit price ≥ 100 RON

### 3. Mapping (Intermediate Operation)
```java
.map(function)
```
Transforms each element to another form.

Example from your code:
```java
.map(Produs::getFirma)
```
Converts stream of Products to stream of company names

### 4. Sorting (Intermediate Operation)
```java
.sorted() // natural order
.sorted(comparator) // custom order
```

Example from your code:
```java
.sorted((p, q) -> Float.compare(q.getCantitate(), p.getCantitate()))
```
Sorts products by quantity in descending order

### 5. Distinct (Intermediate Operation)
```java
.distinct()
```
Removes duplicate elements based on equals()

Example from your code:
```java
.distinct()
```
Removes duplicate company names

### 6. Terminal Operations

#### forEach
```java
.forEach(consumer)
```
Performs action for each element

Example from your code:
```java
.forEach(System.out::println)
```
Prints each element

#### collect
```java
.collect(collector)
```
Converts stream to collection or other structure

Example from your code:
```java
.collect(Collectors.toList())
```
Collects results into a List

#### reduce
```java
.reduce(identity, accumulator)
```
Combines elements into single result

#### count
```java
.count()
```
Returns count of elements

#### average/sum
```java
.average()
.sum()
```
For numeric streams

Example from your code:
```java
.mapToFloat(Produs::getPretUnitar)
.average()
.orElse(0.0)
```
Calculates average unit price

## Your Complete Examples Explained

### 1. Filtering and Sorting Products
```java
produse.stream()
    .filter(p -> p.getPretUnitar() >= 100)
    .sorted((p, q) -> Float.compare(q.getCantitate(), p.getCantitate()))
    .forEach(System.out::println);
```
- Takes list of products
- Keeps only products with price ≥ 100 RON
- Sorts by quantity in DESCENDING order (note reversed p,q)
- Prints each product

### 2. Distinct Companies
```java
produse.stream()
    .map(Produs::getFirma)
    .distinct()
    .sorted()
    .forEach(System.out::println);
```
- Takes list of products
- Extracts company names
- Removes duplicates
- Sorts alphabetically
- Prints each company name

### 3. Filtering by Total Value
```java
List<Produs> produseMax1000 = produse.stream()
    .filter(p -> p.getCantitate() * p.getPretUnitar() <= 1000)
    .collect(Collectors.toList());
```
- Takes list of products
- Keeps products where (quantity × price) ≤ 1000
- Collects results into new List

### 4. Average Price Calculation
```java
float pretMediu = produse.stream()
    .mapToFloat(Produs::getPretUnitar)
    .average()
    .orElse(0.0);
```
- Takes list of products
- Converts to stream of float prices
- Calculates average
- Returns 0.0 if empty stream

## Additional Useful Stream Operations

### 1. Limit/Skip
```java
.limit(n) // take first n elements
.skip(n)  // skip first n elements
```

### 2. Finding Elements
```java
.findFirst() // first element
.findAny()   // any element
.anyMatch()  // if any matches
.allMatch()  // if all match
.noneMatch() // if none match
```

### 3. Grouping
```java
.collect(Collectors.groupingBy(Produs::getFirma))
```
Groups products by company

### 4. Joining Strings
```java
.collect(Collectors.joining(", "))
```
Concatenates strings with delimiter

### 5. Statistics
```java
DoubleSummaryStatistics stats = produse.stream()
    .mapToDouble(Produs::getPretUnitar)
    .summaryStatistics();
```
Gets count, sum, min, max, average

## Performance Considerations

1. Streams are lazy - operations only execute when terminal operation is called
2. Intermediate operations are pipelined
3. Avoid stateful operations in parallel streams
4. Prefer method references where possible (Produs::getPretUnitar)
5. Reuse streams - create once, use multiple times

## Parallel Streams

```java
produse.parallelStream()
```
- Automatically uses multiple threads
- Useful for large datasets
- Be careful with stateful operations
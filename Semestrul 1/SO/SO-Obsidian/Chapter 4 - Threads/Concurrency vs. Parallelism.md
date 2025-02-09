
- ## [[Concurrency]]
- ## [[Parallelism]]

## <span style="color:rgb(112, 48, 160)">Comparison</span>

- **Execution:**
  - *Concurrency:* Tasks are interleaved (e.g., via context switching on a single core).
  - *Parallelism:* Tasks run simultaneously on separate cores or processors.
  
- **Objective:**
  - *Concurrency:* Aims to manage multiple tasks effectively and improve system responsiveness.
  - *Parallelism:* Aims to reduce execution time by performing many operations at the same time.
  
- **Implementation Requirements:**
  - *Concurrency:* Can be achieved on a single-core system; does not require multiple processors.
  - *Parallelism:* Requires multiple processing units (multi-core CPUs or multiple machines).
  
- **Relationship:**
  - Concurrency is a design principle that deals with the structure and management of multiple tasks.
  - Parallelism is an execution strategy that takes advantage of hardware capabilities to perform tasks simultaneously.
  
## <span style="color:rgb(112, 48, 160)">Summary</span>

- **<span style="color:rgb(112, 48, 160)">Concurrency</span>** involves dealing with multiple tasks in an overlapping manner, allowing for interleaved execution.
- **<span style="color:rgb(112, 48, 160)">Parallelism</span>** involves executing multiple tasks simultaneously, leveraging multi-core or multi-processor systems.
- While concurrency improves the structure and responsiveness of programs, parallelism is used to enhance performance by reducing overall execution time.
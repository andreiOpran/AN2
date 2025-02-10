
- One consequence of using synchronization tools to coordinate access to critical sections is the possibility that a process attempting to enter its critical section will <span style="color:rgb(112, 48, 160)">wait indefinitely</span>.
- Indefinite waiting violates the <span style="color:rgb(112, 48, 160)">progress</span> and <span style="color:rgb(112, 48, 160)">bounded-waiting</span> criteria.

- <span style="color:rgb(112, 48, 160)">Liveness</span> refers to a set of properties that a system must satisfy to ensure that processes make progress during their execution life cycle. A4 process waiting indefinitely under the circumstances just described is an example of a <span style="color:rgb(112, 48, 160)">“</span><span style="color:rgb(112, 48, 160)">liveness failure</span><span style="color:rgb(112, 48, 160)">”</span>:
	- [[Deadlock (Chapter 6-7)]]
	- [[Chapter 8 - Deadlocks]]
	- [[Priority Inversion]]


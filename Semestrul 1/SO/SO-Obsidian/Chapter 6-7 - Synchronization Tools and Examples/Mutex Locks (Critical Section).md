
- We use the <span style="color:rgb(112, 48, 160)">mutex lock</span> to protect critical sections and thus prevent race conditions.
- That is, a process must <span style="color:rgb(112, 48, 160)">acquire the lock</span> before entering a critical section. 
- It <span style="color:rgb(112, 48, 160)">releases the lock</span> when it exits the critical section. 
- The `acquire()` function acquires the lock, and the `release()` function releases the lock, as illustrated in Figure 6.10.

![[Pasted image 20250210153947.png]]

```C
void acquire() {
    while (!available)
        ; // Busy wait
    available = false;
}
```

```C
void release() {
    available = true;
}
```

- Locks are either <span style="color:rgb(112, 48, 160)">contended</span> or <span style="color:rgb(112, 48, 160)">uncontended</span>. 
	- A lock is considered contended if a thread blocks while trying to acquire the lock.
	- If a lock is available when a thread attempts to acquire it, the lock is considered uncontended

---

- The main disadvantage of the implementation given here is that it requires <span style="color:rgb(112, 48, 160)">busy waiting</span>.
- While a process is in its critical section, any other process that tries to enter its critical section must loop continuously in the call to acquire(). This continual looping is clearly a problem in a real multiprogramming system, where a single CPU core is shared among many processes. Busy waiting also wastes CPU cycles that some other process might be able to use productively.
	- Spinlocks do have an <span style="color:rgb(112, 48, 160)">advantage</span>, however, in that <span style="color:rgb(112, 48, 160)">no context switch</span> is required when a process must wait on a lock, and a context switch may take considerable time. 
	- In certain circumstances on multicore systems, spinlocks are in fact the preferable choice for locking. If a lock is to be held for a short duration, one thread can “spin” on one processing core while another thread performs its critical section on another core
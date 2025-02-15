
- A <span style="color:rgb(112, 48, 160)">semaphore</span> S is an integer variable that, apart from initialization, is accessed only through two standard atomic operations: <span style="color:rgb(112, 48, 160)">wait()</span> and <span style="color:rgb(112, 48, 160)">signal()</span>.

```c name=semaphore_wait.c
void wait(int S) {
    while (S <= 0)
        ; // Busy wait
    S--;
}
```

```c name=semaphore_signal.c
void signal(int S) {
    S++;
}
```

- All modifications to the integer value of the semaphore in the wait() and signal() operations must be executed <span style="color:rgb(112, 48, 160)">atomically</span>.
	- That is, when one process modifies the semaphore value, no other process can simultaneously modify that same semaphore value. 
	- In addition, in the case of wait(S), the testing of the integer value of S (S ≤ 0), as well as its possible modification (S--), must be executed without interruption

- There are 2 types of semaphores:
	1. <span style="color:rgb(112, 48, 160)">binary semaphores</span> can be used as [[Mutex Locks (Critical Section)|mutex locks]].
	2. the value of a <span style="color:rgb(112, 48, 160)">counting semaphore</span> can range over an unrestricted domain.

---

#### <span style="color:rgb(112, 48, 160)">Semaphore implementation</span>:

- Each semaphore has an integer value and a list of processes list. When a process must wait on a semaphore, it is added to the list of processes. A signal() operation removes one process from the list of waiting processes and awakens that process.

```c name=semaphore.h
typedef struct {
    int value;
    struct process *list;
} semaphore;

void wait(semaphore *S) {
    S->value--;
    if (S->value < 0) {
        // Add this process to S->list
        // sleep();
    }
}

void signal(semaphore *S) {
    S->value++;
    if (S->value <= 0) {
        // Remove a process P from S->list
        // wakeup(P);
    }
}
```


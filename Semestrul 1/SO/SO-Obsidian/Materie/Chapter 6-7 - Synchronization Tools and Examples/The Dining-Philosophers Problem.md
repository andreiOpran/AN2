
- Consider five philosophers who spend their lives thinking and eating. The philosophers share a circular table surrounded by five chairs, each belonging to one philosopher. In the center of the table is a bowl of rice, and the table is laid with five single chopsticks (Figure 7.5). When a philosopher thinks, she does not interact with her colleagues. From time to time, a philosopher gets hungry and tries to pick up the two chopsticks that are closest to her (the chopsticks that are between her and her left and right neighbors). A philosopher may pick up only one chopstick at a time. Obviously, she cannot pick up a chopstick that is already in the hand of a neighbor. When a hungry philosopher has both her chopsticks at the same time, she eats without releasing the chopsticks. When she is finished eating, she puts down both chopsticks and starts thinking again.
	- ![[Pasted image 20250210232527.png]]


- The <span style="color:rgb(112, 48, 160)">dining-philosophers problem</span> is a simple representation of the need to allocate several resources among several processes in a deadlock-free and starvation-free manner.

--- 

#### <span style="color:rgb(112, 48, 160)">Semaphore solution</span> 

- One simple solution is to represent each <span style="color:rgb(112, 48, 160)">chopstick</span> with a <span style="color:rgb(112, 48, 160)">semaphore</span>. 
- A philosopher tries to grab a chopstick by executing a <span style="color:rgb(112, 48, 160)">wait()</span> operation on that semaphore. She releases her chopsticks by executing the <span style="color:rgb(112, 48, 160)">signal()</span> operation on the appropriate semaphores. 
- Thus, the <span style="color:rgb(112, 48, 160)">shared data</span> are `semaphore chopstick[5];` where all the elements of chopstick are initialized to 1. 
- The <span style="color:rgb(112, 48, 160)">structure of philosopher i</span> is shown in Figure 7.6.
- ![[Pasted image 20250210232941.png]]

- Although this solution guarantees that no two neighbors are eating simultaneously, it nevertheless must be <span style="color:rgb(112, 48, 160)">rejected</span> because it could create a <span style="color:rgb(112, 48, 160)">deadlock</span>. 
- Suppose that all five philosophers become hungry at the same time and each grabs her left chopstick. All the elements of chopstick will now be equal to 0. When each philosopher tries to grab her right chopstick, she will be <span style="color:rgb(112, 48, 160)">delayed forever</span>.
- Several possible remedies to the <span style="color:rgb(112, 48, 160)">deadlock</span> problem are the following:
	- Allow at most four philosophers to be sitting simultaneously at the table.
	- Allow a philosopher to pick up her chopsticks only if both chopsticks are available (to do this, she must pick them up in a critical section).
	- Use an asymmetric solution—that is, an odd-numbered philosopher picks up first her left chopstick and then her right chopstick, whereas an even-numbered philosopher picks up her right chopstick and then her left chopstick.

- <span style="color:rgb(112, 48, 160)">Note</span>, however, that any satisfactory solution to the dining-philosophers problem must guard against the possibility that one of the philosophers will starve to death. 
- A deadlock-free solution does not necessarily eliminate the possibility of starvation.

--- 

#### <span style="color:rgb(112, 48, 160)">Monitor solution</span> 


- Next, we illustrate [[Monitors|monitor]] concepts by presenting a deadlock-free solution to the <span style="color:rgb(112, 48, 160)">dining-philosophers problem</span>. 
- This solution imposes the restriction that a philosopher may pick up her chopsticks only if both of them are available. To code this solution, we need to distinguish among three states in which we may find a philosopher. 
- For this purpose, we introduce the following data structure:
	- `enum {THINKING, HUNGRY, EATING} state[5];`
- <span style="color:rgb(112, 48, 160)">Philosopher i</span> can set the variable state\[i] = EATING only if her two neighbors are not eating:
	- (state\[(i+4) % 5] != EATING) and (state\[(i+1) % 5] != EATING).
- We also need to declare condition `self[5];` This allows <span style="color:rgb(112, 48, 160)">philosopher i</span> to delay herself when she is hungry but is unable to obtain the chopsticks she needs.

- We are now in a position to describe<span style="color:rgb(112, 48, 160)"> our solution</span> to the dining-philosophers problem. 
- The distribution of the chopsticks is controlled by the monitor `DiningPhilosophers`, whose definition is shown in Figure 7.7. 
- ![[Pasted image 20250211002036.png]]
- Each philosopher, before starting to eat, must invoke the operation `pickup()`. This act may result in the suspension of the philosopher process. 
- After the <span style="color:rgb(112, 48, 160)">successful completion</span> of the operation, the <span style="color:rgb(112, 48, 160)">philosopher may eat</span>. Following this, the philosopher invokes the `putdown()` operation. Thus, <span style="color:rgb(112, 48, 160)">philosopher i </span>must invoke the operations `pickup()` and `putdown()` in the following sequence:
```C
DiningPhilosophers.pickup(i); 
	... 
	eat 
	...
DiningPhilosophers.putdown(i);
```

- It is easy to show that this <span style="color:rgb(112, 48, 160)">solution ensures that no two neighbors are eating simultaneously </span>and that <span style="color:rgb(112, 48, 160)">no deadlocks</span> will occur. 
- As we already noted, <span style="color:rgb(112, 48, 160)">however</span>, it is possible for a philosopher to <span style="color:rgb(112, 48, 160)">starve to death</span>. 
- We do not present a solution to this problem but rather leave it as an exercise for you.
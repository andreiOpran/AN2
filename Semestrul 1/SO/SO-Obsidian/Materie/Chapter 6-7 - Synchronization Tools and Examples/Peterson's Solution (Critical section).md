
- Because of the way modern computer architectures perform basic machine-language instructions, such as `load` and `store`, there are no guarantees that <span style="color:rgb(112, 48, 160)">Peterson’s solution</span> will work correctly on such architectures. However, we present the solution because it provides a good algorithmic description of solving the critical-section problem and illustrates some of the complexities involved in designing software that addresses the requirements of <span style="color:rgb(112, 48, 160)">mutual exclusion</span>, <span style="color:rgb(112, 48, 160)">progress</span>, and <span style="color:rgb(112, 48, 160)">bounded waiting</span>.

- Peterson’s solution is restricted to two processes that alternate execution between their critical sections and remainder sections. The processes are numbered P0 and P1. For convenience, when presenting Pi , we use Pj to denote the other process; that is, j equals 1 − i.

- Peterson’s solution requires the two processes to <span style="color:rgb(112, 48, 160)">share two data items</span>:

```C
int turn; 
boolean flag[2];

while (true) 
{
    flag[i] = true;
    turn = j;
    while (flag[j] && turn == j)
        ; // Busy wait
        
	    /* Critical section */

    flag[i] = false;

	    /* Remainder section */
}
```

---
### <span style="color:rgb(112, 48, 160)">Where it does not work:</span>

![[Pasted image 20250210160105.png]]
![[Pasted image 20250210160116.png]]
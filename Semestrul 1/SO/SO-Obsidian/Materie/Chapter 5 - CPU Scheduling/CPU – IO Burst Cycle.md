
- The success of CPU scheduling depends on an observed property of processes: 
	- Process execution consists of a <span style="color:rgb(112, 48, 160)">cycle</span> of CPU execution and I/O wait. Processes alternate between these two states. 
	- Process execution begins with a <span style="color:rgb(112, 48, 160)">CPU burst</span>. That is followed by an<span style="color:rgb(112, 48, 160)"> I/O burst</span>, which is followed by another CPU burst, then another I/O burst, and so on. 
	- Eventually, the <span style="color:rgb(112, 48, 160)">final CPU burst ends</span> with a system request to terminate execution (Figure 5.1). 
- The <span style="color:rgb(112, 48, 160)">durations of CPU bursts</span> have been measured extensively. Although they vary greatly from process to process and from computer to computer, they tend to have a frequency curve similar to that shown in Figure 5.2. 
- The curve is generally characterized as <span style="color:rgb(112, 48, 160)">exponential</span> or <span style="color:rgb(112, 48, 160)">hyperexponential</span>, with a large number of short CPU bursts and a small number of long CPU bursts. 
	- An I/O-bound program typically has many short CPU bursts.
	- A CPU-bound program might have a few long CPU bursts. 
		- This distribution can be important when implementing a CPU-scheduling algorithm.

![[Pasted image 20250212004216.png]]
![[Pasted image 20250212004223.png]]
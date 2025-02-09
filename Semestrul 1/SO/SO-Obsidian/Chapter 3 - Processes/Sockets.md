- A <span style="color:rgb(112, 48, 160)">socket</span> is defined as an endpoint for communication.
- A pair of processes communicating over a network employs a pair of sockets—one for each process. 
- A socket is identified by an <span style="color:rgb(112, 48, 160)">IP address</span> concatenated with a<span style="color:rgb(112, 48, 160)"> port number</span>.
- In general, sockets use a <span style="color:rgb(112, 48, 160)">client–server architecture</span>. The server waits for incoming client requests by listening to a specified port. Once a request is received, the server accepts a connection from the client socket to complete the connection. 
- Servers implementing specific services (such as SSH, FTP, and HTTP) listen to well-known ports 
	- an SSH server listens to port <span style="color:rgb(112, 48, 160)">22</span>
	- an FTP server listens to port <span style="color:rgb(112, 48, 160)">21</span>
	- and a web, or HTTP, server listens to port <span style="color:rgb(112, 48, 160)">80</span> 
		- All ports below <span style="color:rgb(112, 48, 160)">1024</span> are considered well known and are used to implement <span style="color:rgb(112, 48, 160)">standard services</span>.


![[Pasted image 20250209212721.png]]
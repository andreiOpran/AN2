
- <span style="color:rgb(112, 48, 160)">Thread cancellation</span> involves terminating a thread before it has completed.
- For example, if multiple threads are concurrently searching through a database and one thread returns the result, the remaining threads might be canceled.
- Another situation might occur when a user presses a button on a web browser that stops a web page from loading any further. Often, a web page loads using several threads—each image is loaded in a separate thread. When a user presses the stop button on the browser, all threads loading the page are canceled.
- A thread that is to be canceled is often referred to as the <span style="color:rgb(112, 48, 160)">target thread</span>. 
- <span style="color:rgb(112, 48, 160)">Cancellation of a target thread</span> may occur in<span style="color:rgb(112, 48, 160)"> two different scenarios</span>:
	1. <span style="color:rgb(112, 48, 160)">Asynchronous cancellation.</span> One thread immediately terminates the target thread.
	2. <span style="color:rgb(112, 48, 160)">Deferred cancellation</span>. The target thread periodically checks whether it should terminate, allowing it an opportunity to terminate itself in an orderly fashion.
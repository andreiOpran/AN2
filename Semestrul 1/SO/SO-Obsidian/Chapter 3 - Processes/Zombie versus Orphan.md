
- When a process terminates, its resources are deallocated by the operating system. However, its entry in the process table must remain there until the parent calls <span style="color:rgb(112, 48, 160)">wait()</span>, because the process table contains the process’s exit status. A process that has <span style="color:rgb(112, 48, 160)">terminated</span>, but whose <span style="color:rgb(112, 48, 160)">parent has not yet called wait()</span>, is known as a <span style="color:rgb(112, 48, 160)">zombie</span> process.
- All processes transition to this state when they terminate, but generally they exist as zombies only briefly. Once the parent calls wait(), the process identifier of the zombie process and its entry in the process table are released.

---

- Now consider what would happen if a parent <span style="color:rgb(112, 48, 160)">did not invoke wait()</span> and <span style="color:rgb(112, 48, 160)">instead terminated</span>, thereby leaving its child processes as <span style="color:rgb(112, 48, 160)">orphans</span>.
- Traditional UNIX systems addressed this scenario by assigning the [[Init Process]] as the <span style="color:rgb(112, 48, 160)">new parent to orphan processes</span>. The init process periodically invokes wait(), thereby allowing the exit status of any orphaned process to be collected and releasing the orphan’s process identifier and process-table entry.
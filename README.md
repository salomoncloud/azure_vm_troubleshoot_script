# azure_vm_troubleshoot_script
---
Another useful script I use at work. this has helped me investigate vm's that ring up hundreds of cpu utilization alerts a week. This is what it does.

Uptime and Load: Displays system load averages to quickly gauge if the system is under heavy load.

Memory Usage: Prints both total and available memory in a human-readable format.

Disk Usage: Shows which filesystems may be near capacity.

I/O Statistics (if available): Provides insight into disk performance and potential bottlenecks.

Process Listing by CPU and Memory: Separates the top CPU-consuming and top memory-consuming processes for easier identification.

Network Information (if available): Quick snapshot of active network connections, useful if troubleshooting performance related to network traffic.

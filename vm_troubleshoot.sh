#!/bin/bash

echo "----------------------------------------"
echo "Performance Investigation Script"
echo "Date and Time: $(date)"
echo "----------------------------------------"

# Show system load averages and uptime
echo -e "\n--- System Load ---"
uptime

# Show memory usage
echo -e "\n--- Memory Usage ---"
free -h

# Show disk usage
echo -e "\n--- Disk Usage ---"
df -h

# If iostat is available, show I/O stats
if command -v iostat &> /dev/null
then
    echo -e "\n--- I/O Statistics (iostat) ---"
    iostat -x 1 1
else
    echo -e "\n[iostat not found, skipping I/O stats]"
fi

# Show top 10 processes by CPU usage
echo -e "\n--- Top 10 CPU-Consuming Processes ---"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 11

# Show top 10 processes by memory usage
echo -e "\n--- Top 10 Memory-Consuming Processes ---"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 11

# Optional: Network usage (if netstat is available)
if command -v netstat &> /dev/null
then
    echo -e "\n--- Active Network Connections ---"
    netstat -tunlp
else
    echo -e "\n[netstat not found, skipping network info]"
fi

echo -e "\n----------------------------------------"
echo "End of Performance Investigation"
echo "----------------------------------------"

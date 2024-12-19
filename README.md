# azure_vm_troubleshoot_script
---
Another useful script I use at work. this has helped me investigate vm's that ring up hundreds of cpu utilization alerts a week. This is what it does.

Uptime and Load: Displays system load averages to quickly gauge if the system is under heavy load.

Memory Usage: Prints both total and available memory in a human-readable format.

Disk Usage: Shows which filesystems may be near capacity.

I/O Statistics (if available): Provides insight into disk performance and potential bottlenecks.

Process Listing by CPU and Memory: Separates the top CPU-consuming and top memory-consuming processes for easier identification.

Network Information (if available): Quick snapshot of active network connections, useful if troubleshooting performance related to network traffic.

Here is an example of the output it provides, coming from a real troubleshoot using azure run command:

Enable succeeded: 
[stdout]
  880M  14% /boot
/dev/mapper/vg_scc_auditlog-lv_auditlog        8.0G   41M  8.0G   1% /scc_auditlog
/dev/sda2                                      512M  320K  512M   1% /boot/efi
/dev/mapper/vg_hana_shared_H4C-lv_hana_shared   64G   62G  2.3G  97% /hana/shared
/dev/mapper/vg_usr_sap_H4C-lv_usr_sap           32G  1.8G   31G   6% /usr/sap
/dev/mapper/vg_usr_sap_trans-lv_usr_sap_trans   64G   32G   33G  50% /usr/sap/trans
/dev/mapper/vg_sapmedia-lv_sapmedia            1.0T  206G  818G  21% /sapmedia
/dev/sdb1                                       63G   47G   13G  79% /mnt
tmpfs                                          3.2G  4.0K  3.2G   1% /run/user/1027
tmpfs                                          3.2G  4.0K  3.2G   1% /run/user/172

--- I/O Statistics (iostat) ---
Linux 5.14.21-150400.24.125-default (vmh4cmgt002) 	12/19/2024 	_x86_64_	(4 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          21.65    0.00    7.47    0.04    0.00   70.84

Device            r/s     w/s     rkB/s     wkB/s   rrqm/s   wrqm/s  %rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz  svctm  %util
sdb              0.06    0.02      0.71     17.38     0.11     0.77  65.01  97.53    0.48  456.19   0.01    11.47   895.88   1.75   0.01
sde              0.00    0.00      0.01      0.01     0.00     0.00   0.00  33.50    2.57    1.82   0.00    17.16    38.58   2.38   0.00
sdf              0.00    0.00      0.08      0.00     0.00     0.00   0.00   0.00   21.04    6.10   0.00    22.08    20.05   6.05   0.00
sdd              0.03    0.32      0.38      2.57     0.00     0.05   0.02  12.36    5.50    1.78   0.00    15.28     8.04   1.45   0.05
sdc              1.30    3.00    649.62     63.70     0.02     0.28   1.82   8.51   32.53   10.79   0.07   501.46    21.22   2.68   1.15
sdg              0.00    0.00      0.00      0.00     0.00     0.00   0.00   0.00    2.64    2.06   0.00    40.88    28.88   3.67   0.00
sda              0.24   16.77      5.78    199.65     0.00     1.43   0.41   7.83    1.17    1.42   0.03    24.53    11.90   1.35   2.29
dm-0             0.00    0.00      0.01      0.01     0.00     0.00   0.00   0.00    2.62    1.12   0.00    14.52    25.66   2.06   0.00
dm-1             0.00    0.00      0.00      0.00     0.00     0.00   0.00   0.00    2.78    0.84   0.00    23.56    29.23   2.98   0.00
dm-2             0.94    3.27    649.62     63.70     0.00     0.00   0.00   0.00   21.64    7.18   0.04   691.95    19.48   2.73   1.15
dm-3             0.03    0.37      0.38      2.57     0.00     0.00   0.00   0.00    5.50    0.65   0.00    15.21     7.05   1.28   0.05
dm-4             0.00    0.00      0.08      0.00     0.00     0.00   0.00   0.00   21.24    4.86   0.00    21.69    20.05   6.05   0.00


--- Top 10 CPU-Consuming Processes ---
  PID  PPID CMD                         %MEM %CPU
 8847  8820 hdbnameserver                8.0 79.2
 9073  8820 /hana/shared/H4C/xs/bin/xsc  1.2  1.9
    1     0 /usr/lib/systemd/systemd di  0.0  1.8
11068 11066 python3 src/MdeInstallerWra  0.0  1.5
19983  9073 META-INF/.sap_java_buildpac  2.4  1.3
 2209     1 /opt/microsoft/mdatp/sbin/w  0.3  1.1
 2360  2209 /opt/microsoft/mdatp/sbin/w  0.2  1.1
11436 10727 [bash] <defunct>             0.0  2.5
11482     1 /var/lib/waagent/Microsoft.  0.0 14.2
12011     1 /opt/microsoft/azuremonitor  0.1  1.0

--- Top 10 Memory-Consuming Processes ---
  PID  PPID CMD                         %MEM %CPU
 8847  8820 hdbnameserver                8.0 79.2
19983  9073 META-INF/.sap_java_buildpac  2.4  1.3
 4034     1 /opt/sapjvm_8/bin/java -Xtr  2.3  0.3
 9076  8820 /hana/shared/H4C/xs/bin/xsu  2.1  0.3
17828  9073 META-INF/.sap_java_buildpac  2.0  0.4
20573  9073 META-INF/.sap_java_buildpac  1.4  0.3
11423  9073 META-INF/.sap_java_buildpac  1.4  0.2
11540  9073 META-INF/.sap_java_buildpac  1.3  0.2
 9073  8820 /hana/shared/H4C/xs/bin/xsc  1.2  1.9
 6396  6299 /usr/sap/DAA/SMDA98/exe/jst  1.1  0.7

[netstat not found, skipping network info]

----------------------------------------
End of Performance Investigation
----------------------------------------

[stderr]

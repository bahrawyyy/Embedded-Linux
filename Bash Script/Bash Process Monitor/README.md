# Process Monitoring Script
An interactive Bash script that serves as a simple process monitor, allowing users to view, manage, and analyze running processes on a Unix-like system.

## Features
- Real time monitoring processes
  - List the most recent 10 processes with essential information (PID, name, CPU/Memory usage)
  - Updated each {UPDATE_INTERVAL} seconds.    
  
![RealTimeMonitoring](https://github.com/bahrawyyy/Embedded-Linux/assets/71684437/f6cd6601-0dd5-421a-a61c-d569cdb13314)

- Process detaild information
  - Provide detailed information about a specific process, including its PID, parent process ID, etc.

![ProcessInDetails](https://github.com/bahrawyyy/Embedded-Linux/assets/71684437/1aed23ee-089f-4789-b51c-dbeb5b0f09ad)

- Kill a proces
  - Allow users to kill a process be entering its ID.
  - Append the killing status to the log file "logFileMonitor.txt"

![KillAndLogFile](https://github.com/bahrawyyy/Embedded-Linux/assets/71684437/ebbe13f4-21ca-4801-ba03-2ca2a3f4731d)

- Process statistics
  - Display overall system process statistics, such as the total number of processes, memory usage, and CPU load.

![ProcessStats](https://github.com/bahrawyyy/Embedded-Linux/assets/71684437/88899e23-c5db-47e3-9ecf-008f029a3f53)

- Search and filter
  - Search and filter with process name or username
  - Get the most 3 consuming CPU and memory processes
 
![SearchNameAndUser](https://github.com/bahrawyyy/Embedded-Linux/assets/71684437/8bb040b6-f4b6-4106-a395-2a4633fffdae)

![MostConsuming](https://github.com/bahrawyyy/Embedded-Linux/assets/71684437/af6a09cc-f161-4dd9-ac8d-5615efa53b13)

- Configuration file and Resource usage alerts
  - Users can create a configuration file (e.g., process_monitor.conf) with settings like {UPDATE_INTERVAL}, {CPU_ALERT_THRESHOLD}, {MEMORY_ALERT_THRESHOLD}.
  - Based on the thresholds specified in this files, the script send alerts to user with the process name that exceeds this threshold.
  - An example of the config file can be found in this directory under the name "process_monitor.conf"

![Guide](https://github.com/bahrawyyy/Embedded-Linux/assets/71684437/0b783d50-488e-4b44-8680-db5f6c27142e)



# DLT Log Analyzer

## Project Title: DLT Log Analyzer

### Project Overview
Create a Bash script that automates the process of analyzing Diagnostic Log and Trace (DLT) files. The script should provide functionalities to parse, filter, and summarize the log data, focusing on identifying common errors, warnings, and specific event occurrences within the log files.

### Sample DLT Log Content
You can find an example of the content of a dlt file in dlt_example.dlt


### Project Requirements

1. **Log Parsing**
   - Extract key pieces of information from each log entry, such as timestamp, log level (INFO, WARN, ERROR, DEBUG), and the message.
   ![image](https://github.com/bahrawyyy/Embedded-Linux/assets/71684437/1546e835-25e6-4b27-b877-0b0caf72a243)

2. **Menu to choose an option from**
   - The user will choose an option from this menu  
   ![image](https://github.com/bahrawyyy/Embedded-Linux/assets/71684437/85c09267-96dc-497d-9063-68dabeeb7dac)

3. **Filtering**
   - Provide options to filter the log entries by log level. For example, a user might be interested only in ERROR and WARN level messages.
   ![image](https://github.com/bahrawyyy/Embedded-Linux/assets/71684437/e867d873-796b-4acb-9572-0a56db2b2bb3)

4. **Error and Warning Summary**
   - Summarize errors and warnings, providing counts and details for each type encountered in the log.  
   ![image](https://github.com/bahrawyyy/Embedded-Linux/assets/71684437/4ec387c3-a0f8-4b95-9766-12099e2d2b59)

4. **Event Tracking**
   - Track specific events, such as "System Startup Sequence Initiated" and "System health check OK", to ensure critical processes are starting and completing as expected.
   ![image](https://github.com/bahrawyyy/Embedded-Linux/assets/71684437/3e6d3e33-9025-4ab0-957d-6dfef9c367c6)

5. **Report Generation**
   - Generate a report summarizing the findings, including any trends identified in the error/warning logs and the status of system events.
   - You can find an example of the report generation output in dlt_report.txt
   - You can define the path to this report from dlt_configurations.conf file
   ![image](https://github.com/bahrawyyy/Embedded-Linux/assets/71684437/360d7f4a-080f-4ff6-8fa6-9db3a30989f6)

### Instructions

1. Create a file named `dlt_configurations.conf` to be used in events tracking and report file path.
2. Run the script using the command: `./dlt_LogAnalyzer.sh dlt_example.dlt`

---
Feel free to customize the script according to your specific requirements and environment.


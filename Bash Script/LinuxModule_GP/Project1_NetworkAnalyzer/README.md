# Network Traffic Analysis Task

## Objective
The primary objective of this network task is to analyze network traffic using Wireshark and automate specific tasks with a Bash script, generating a summary report.

## Scope
- Capture network traffic using Wireshark.
- Develop a Bash script to analyze the captured data.
- Extract relevant information like total packets, protocols, and top source/destination IP addresses.
- Generate a summary report based on the analysis.

## Prerequisites
- Wireshark installed.
- Permission to capture network traffic.
- Basic Bash scripting knowledge.

## Instructions
### 1. Wireshark Capture
- Start Wireshark and capture network traffic.
- Save the captured data in a pcap file (e.g., your_capture_file.pcap).

### 2. Bash Script
- Create a Bash script named `analyze_traffic.sh`.
- Use the script to:
  - Specify the path to the Wireshark pcap file.
  - Analyze the data to identify patterns.
  - Extract information like total packets, protocols, etc.
  - Generate a summary report.

### 3. Bash Script Startup Code
```bash
#!/bin/bash

# Bash Script to Analyze Network Traffic

# Input: Path to the Wireshark pcap file
pcap_file=$1  # capture input from terminal.

# Function to extract information from the pcap file
analyze_traffic() {
    # Use tshark or similar commands for packet analysis.
    # Hint: Consider commands to count total packets, filter by protocols (HTTP, HTTPS/TLS),
    # extract IP addresses, and generate summary statistics.

    # Output analysis summary
    echo "----- Network Traffic Analysis Report -----"
    # Provide summary information based on your analysis
    # Hints: Total packets, protocols, top source, and destination IP addresses.
    echo "1. Total Packets: [your_total_packets]"
    echo "2. Protocols:"
    echo "   - HTTP: [your_http_packets] packets"
    echo "   - HTTPS/TLS: [your_https_packets] packets"
    echo ""
    echo "3. Top 5 Source IP Addresses:"
    # Provide the top source IP addresses
    echo "[your_top_source_ips]"
    echo ""
    echo "4. Top 5 Destination IP Addresses:"
    # Provide the top destination IP addresses
    echo "[your_top_dest_ips]"
    echo ""
    echo "----- End of Report -----"
}

# Run the analysis function
analyze_traffic
```

## Expected Input
- Pass your pcap file when running the script
```cmd
./Net_Analysis.sh NetAn.pcap 
```

## Output
![image](https://github.com/bahrawyyy/Embedded-Linux/assets/71684437/8575bcbc-1325-4517-9dc4-12b129bac363)


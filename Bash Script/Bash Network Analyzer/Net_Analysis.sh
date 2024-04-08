#!/bin/bash

# Bash Script to Analyze Network Traffic

# Input: Path to the Wireshark pcap file
pcap_file="$1" # capture input from terminal.

# Variable to specify number of IP addresses you want to display
LINESCOUNT=5


# A function to count the total Number of packets
getNumPackets() {
    Packets=$(capinfos -c "$1" | grep "packets")
    echo "${Packets: 20}"   # Filtering 20 chars from beginning as the command output is a full string
}

# A function to filter packets based on a specific protocol
filterPackets() {
    tshark -r "$1" -Y "$2"
}

# A function to display top contributing IP src or destination addresses and their packets count
topIpAddresses() {
    tshark -r "$1" -T fields -e "$2" | sort | uniq -c | sort -nr | head -n "$LINESCOUNT"| awk '{print "   - " $2 ": " $1 " packets"}'
}



# Function to extract information from the pcap file
analyze_traffic() {
    # Use tshark or similar commands for packet analysis.
    # Hint: Consider commands to count total packets, filter by protocols (HTTP, HTTPS/TLS),
    # extract IP addresses, and generate summary statistics.

    # Output analysis summary
    echo "----- Network Traffic Analysis Report -----"
    # Provide summary information based on your analysis
    # Hints: Total packets, protocols, top source, and destination IP addresses.
    total_packets=$(getNumPackets "$pcap_file")
    echo "1. Total Packets: $total_packets"
    httpFilter=$(filterPackets "$pcap_file" "http" | wc -l)
    httpsFilter=$(filterPackets "$pcap_file" "tls" | wc -l)
    echo "2. Protocols:"
    echo "   - HTTP: $httpFilter packets"
    echo "   - HTTPS/TLS: $httpsFilter packets"
    echo ""
    echo "3. Top 5 Source IP Addresses:"
    # Provide the top source IP addresses
    topIpAddresses "$pcap_file" "ip.src"
    # echo "[your_top_source_ips]"
    echo ""
    echo "4. Top 5 Destination IP Addresses:"
    # Provide the top destination IP addresses
    topIpAddresses "$pcap_file" "ip.dst"
    echo ""
    echo "----- End of Report -----"
}

# Run the analysis function
analyze_traffic "$pcap_file"

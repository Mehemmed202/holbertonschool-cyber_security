Advanced Nmap Scanning Techniques

This document provides a comprehensive overview of advanced port scanning techniques using Nmap. It covers the mechanics of various scan types, TCP flags (PSH, URG), and how these methods interact with firewalls and IDS/IPS systems.
1. Introduction to Advanced Scans

Unlike standard scans, advanced Nmap scans manipulate TCP header flags to bypass security filters and identify the state of a target port without completing a full connection.
Key Difference: Standard vs. Advanced

    Standard Scans: Typically use the full 3-way handshake (TCP Connect) or half-open (SYN) methods. They are easily logged by modern systems.

    Advanced Scans: Use "illegal" or unexpected flag combinations (NULL, FIN, Xmas) to exploit how different operating systems respond to non-standard packets.

2. Deep Dive: TCP Flags
PSH (Push) Flag

    Function: Instructs the receiving host to bypass the buffer and push the data immediately to the application layer.

    Use Case: Critical for interactive traffic like SSH or Telnet where real-time response is required.

URG (Urgent) Flag

    Function: Indicates that specific data within the segment is "urgent" and should be processed out-of-order.

    Use Case: Used for interrupt signals (e.g., Ctrl+C in a terminal session).

3. Advanced Scan Types & Mechanics
NULL Scan (-sN)

    Mechanism: Sends a packet with no flags set.

    Behavior: According to RFC 793, a closed port should respond with an RST, while an open port should ignore it.

FIN Scan (-sF)

    Mechanism: Sends a packet with only the FIN flag set.

    Behavior: Used to sneak past firewalls that are looking for SYN packets to block new connections.

Xmas Scan (-sX)

    Mechanism: Sets the FIN, PSH, and URG flags simultaneously.

    Behavior: Lights the packet up like a "Christmas tree." It is highly effective against non-Windows systems to determine port status.

ACK Scan (-sA)

    Mechanism: Sends only an ACK flag.

    Goal: It does not determine if a port is open; it determines if a port is Filtered or Unfiltered by a firewall.

4. Bypassing Firewalls & IDS
Stateful Packet Inspection (SPI)

Modern firewalls use SPI to track the state of active connections. They are highly likely to detect Xmas, NULL, and FIN scans because these flag combinations do not belong to a valid connection state.
Packet Fragmentation (-f)

    Description: Breaks the TCP header into several small IP fragments.

    Purpose: To confuse packet filters that do not perform reassembly before inspection, allowing the scan to bypass simple rules.

5. Summary Table
Scan Type	Flag(s) Used	Nmap Command	Target OS Sensitivity
TCP Connect	SYN	nmap -sT	Most logged / No root required
SYN Scan	SYN	nmap -sS	"Stealth" / Standard
NULL Scan	None	nmap -sN	Effective on Linux/Unix
FIN Scan	FIN	nmap -sF	Bypasses SYN-only filters
Xmas Scan	FIN, PSH, URG	nmap -sX	Detectable by SPI firewalls
ACK Scan	ACK	nmap -sA	Map firewall rules
6. Educational Use Case

Advanced scanning is essential for:

    Security Auditing: Verifying firewall rule integrity.

    OS Fingerprinting: Identifying target OS based on how it responds to RFC violations.

    Vulnerability Research: Finding open services behind restrictive filters.

    Disclaimer: This information is for educational and authorized penetration testing purposes only. Unauthorized scanning of networks is illegal.

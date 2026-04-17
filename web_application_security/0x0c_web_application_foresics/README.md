🛡️ Digital Forensics & Web Security Study Notes

Hey there! This repository is a collection of my personal notes, research, and lab results focused on Digital Forensics and Incident Response (DFIR). As a Junior Red Teamer transitioning into a SOC role, I’ve put this together to bridge the gap between "breaking things" and "investigating how things were broken."
📌 Project Overview

The goal of this project is to master the art of digital investigation, from network-level filtering with Linux firewalls to deep-dive web application log analysis.
🧩 Core Concepts Covered
1. Digital Forensics (The "Detective" Work)

    What is it? It’s not just about finding files; it’s about maintaining the Chain of Custody. If you can't prove where a piece of evidence came from, it’s useless in court.

    Volatile Data: This is the "gold mine." Information in RAM or in transit is like ice—it melts (disappears) the moment you pull the plug. Always capture the RAM before shutting down a machine.

    Messaging Forensics: Recovering emails, calendar invites, and contacts to build a timeline of a suspect’s activities.

2. Linux Network Security

    Firewalld vs. Iptables: * iptables is the classic "old school" way (static and manual).

        firewalld is the modern, dynamic approach using Zones.

    Key Command: To check if your shield is up:
    Bash

    systemctl status firewalld

    Pro-tip: When adding rules (like allowing SSH), always use --permanent and follow it up with a --reload. Otherwise, your hard work vanishes after a reboot.

3. Web Application Forensics

Investigation doesn't stop at the OS level. For web apps, we look at:

    Log Analysis: Digging through Apache/Nginx access.log and error.log to spot SQL injections or brute-force attempts.

    The Toolbox: * Wireshark: To see the "heartbeat" of the network.

        Burp Suite: To intercept and analyze the actual payloads being sent to a web app.

📝 Reporting Best Practices (DFIR Style)

A forensic report is only as good as its clarity. Here’s the structure I follow:

    Case Summary: A high-level overview for non-techies (Managers/Legal). No jargon allowed here.

    Evidence & Tools: Precise list of hashes, serial numbers, and the tools used (Autopsy, Wireshark, etc.).

    Table of Contents: Always includes page numbers. In a 100-page report, no one wants to hunt for a specific log entry.

🚀 Learning Objectives

By the end of this folder, you should be able to:

    [x] Explain Digital Forensics without Googling.

    [x] Trace an attack origin using nothing but raw access logs.

    [x] Secure a Linux server using firewall-cmd.

    [x] Document an investigation in a way that would hold up in a professional environment.

    Note to self: Always work on a copy (disk image), never the original evidence. "Flush" the cache if things get weird, but never "flush" your evidence!

How to use these notes?

Feel free to browse the /logs and /scripts directories. If you have questions about the iptables logic or the firewalld rich rules, just ping me!

Peace out! ✌️
Mahammad M.

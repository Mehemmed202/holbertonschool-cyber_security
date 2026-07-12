# Linux Privilege Escalation & System Administration

This repository contains notes, documentation, and practical exercises aimed at mastering Linux privilege escalation vectors and fundamental system administration commands. 

---

## 🎯 Learning Objectives

By the end of this overview, you should be able to confidently explain and demonstrate the following concepts without external references:

### 1. Privilege Escalation Vectors

*   **Kernel Exploits:** Understanding how outdated or unpatched Linux kernels can be exploited to gain root access (e.g., using famous exploits like *Dirty COW*).
*   **SUID/SGID Executables:** Identifying misconfigured binaries with the Set Owner User ID (SUID) or Set Group ID (SGID) bits turned on, and exploiting them using resources like **GTFOBins**.
*   **Exploiting Weak File Permissions:** Locating world-writable files (such as `/etc/passwd` or critical configuration scripts) and utilizing them to escalate privileges.
*   **Cron Jobs & Scheduled Tasks:** Identifying and exploiting misconfigured cron jobs that run with elevated (root) privileges, such as wildcards or writable script paths.
*   **Path Variable Manipulation:** Understanding how an insecure `PATH` environment variable can be manipulated to hijack system commands and execute malicious binaries with higher privileges.
*   **Password Hashes & Credential Reuse:** Extracting, cracking, or reusing password hashes from `/etc/shadow` using cracking tools like **John the Ripper**.
*   **Exploiting Services Running as Root:** Identifying software, applications, or custom services running under the root user context and exploiting known vulnerabilities within them.
*   **Escaping Restricted Shells:** Bypassing restricted shell environments (like `rbash`) using custom scripts, Python, text editors, or **GTFOBins** techniques.
*   **LD_PRELOAD & LD_LIBRARY_PATH Exploits:** Manipulating environmental variables to force a program to load custom, malicious shared libraries before standard ones.
*   **Misconfigured sudo:** Exploiting weak or overly permissive `sudoers` configurations (e.g., binaries allowed to run via `sudo` without a password).

---

### 2. System Administration & Process Management

Mastery of essential commands used to identify, monitor, and defend against malicious activities on a Linux system:

#### 🧵 Process Management
*   `ps`: Identify running processes, check ownership, and spot malicious or unauthorized binaries.
*   `kill`: Safely terminate or force-quit malicious/unresponsive processes.

#### 🌐 Network Monitoring
*   `netstat` & `ss`: Monitor active network connections, routing tables, and interface statistics to spot suspicious outbound or inbound traffic.

#### 🔍 Traffic Analysis & Auditing
*   `nmap`: Scan local or remote systems to identify open ports and running services.
*   `lynis`: Conduct security auditing and vulnerability scanning on Linux systems.
*   `tcpdump`: Capture and analyze raw network traffic traversing system interfaces.

#### 🧱 Firewall & Traffic Management
*   `iptables`: Manage traditional netfilter firewall rules to block or allow traffic.
*   `ufw` (Uncomplicated Firewall): Configure user-friendly firewall rules to secure the host.

---

## 🛠️ Tools Reference

| Tool | Purpose |
| :--- | :--- |
| **GTFOBins** | A curated list of Unix binaries used to bypass local security restrictions. |
| **John the Ripper** | Fast password cracking tool used to test credential strength. |
| **Lynis** | Security auditing tool for hardening Linux/Unix-based systems. |
| **Tcpdump** | Command-line packet analyzer for network troubleshooting and analysis. |

---

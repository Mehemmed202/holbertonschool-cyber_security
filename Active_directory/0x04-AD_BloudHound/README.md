# Active Directory Attack Path Analysis with BloodHound

An offensive and defensive security lab focusing on structured attack path analysis against a live Active Directory environment (`pentestlab.local`). This project demonstrates how to collect, visualize, and exploit complex relationship chains in AD, transitioning from a low-privileged intern account to full Domain Compromise, while analyzing corresponding forensic artifacts.

---

## 📌 Project Overview

This project simulates a realistic enterprise red team engagement. Utilizing **BloodHound** as the primary analytical weapon, the objective is to map out hidden permission paths, abuse Active Directory Access Control Lists (ACLs), execute credential-based attacks, and ultimately achieve persistence through Kerberos ticket forgery. 

In tandem with offensive operations, this repository details the **blue team perspective**—highlighting how defenders detect these exact tactics using Windows Event IDs, PowerShell Logging, and Sysinternals tools.

---

## 🛠️ Tech Stack & Lab Architecture

### Operating Systems (Virtual Environments)
* **Kali Linux:** The offensive platform hosting BloodHound, CrackMapExec, Impacket, and Mimikatz.
* **Windows Server 2019:** The target Domain Controller managing the `pentestlab.local` domain.
* **Windows 11 Enterprise:** The victim workstation hosting active user sessions.

### Primary Tooling
* **BloodHound & Neo4j:** Active Directory graph-based relationship analysis.
* **SharpHound:** Data collection ingestor for AD objects and ACLs.
* **Mimikatz:** In-memory credential extraction and Kerberos ticket manipulation.
* **Impacket Suite:** Tools for network protocol manipulation (AS-REP roasting, Kerberoasting, DCSync).
* **Windows Sysinternals:** Systems diagnostics and monitoring (Process Explorer, Autoruns).

---

## 🚀 Execution Phases (The Attack Path)

### Phase 1: Ingestion & Reconnaissance
* Authenticate using initial low-privileged intern credentials.
* Execute `SharpHound.exe` or `SharpHound.ps1` to collect domain data.
* Import JSON data into the **Neo4j** graph database via BloodHound GUI to uncover the shortest path to `Domain Admin`.

### Phase 2: Weaponization & ACL Abuse
* Analyze BloodHound edges for misconfigured Object Control Access Rights.
* Abuse **GenericAll** privileges on targeted objects to force password resets or alter group memberships.

### Phase 3: Credential Harvesting
* **AS-REP Roasting:** Target accounts with pre-authentication disabled to grab crackable hashes.
* **Kerberoasting:** Request service tickets (TGS) for Service Principal Names (SPNs) and crack them offline via Hashcat.

### Phase 4: Domain Dominance & Persistence
* **DCSync Attack:** Mimic a Domain Controller using Mimikatz (`lsadump::dcsync`) to pull the `krbtgt` NTLM hash.
* **Golden Ticket Forgery:** Construct a lifetime Kerberos Ticket Granting Ticket (TGT) for ultimate persistence.
* **SYSVOL/SMB Enumeration:** Leak sensitive files and scripts from poorly restricted network shares.

---

## 🛡️ Defender's View & Forensic Indicators

Understanding how to break the attack path requires identifying the footprints left behind in Windows Event Logs:

| Attack Stage | Tool/Mechanism | Key Forensic Indicators & Event IDs |
| :--- | :--- | :--- |
| **AD Enumeration** | SharpHound / BloodHound | Massive spike in LDAP queries, anomalous network traffic. |
| **PowerShell Execution** | Obfuscated Scripts | **Event ID 4104** (Script Block Logging - cleartext execution). |
| **Maniupalation Detection** | AMSI Bypass Attempts | **Event ID 4168** (AMSI Tampering), **Event ID 4169** (Blocked Script). |
| **Credential Dumping** | Mimikatz (LSASS Access) | **Event ID 4656 / 4663** (Process access requests to `lsasrv.dll`). |
| **Persistence / Backdoors** | Scheduled Tasks / GPO | **Event ID 4698** (Scheduled Task Created), Monitor `Autoruns` logs. |

---

## 📋 Learning Objectives Achieved

* Graph Theory Application: Visualizing multi-hop attack paths that manual analysis would miss.
* Identity & Access Management (IAM) Auditing: Exploiting and remediating flawed Active Directory ACLs.
* Cryptographic Protocol Attacks: Exploiting flaws within the Kerberos authentication mechanism.
* Detection Engineering: Correlating offensive execution with host-based and network-based Windows telemetry.

---

## 🛑 Disclaimer
This repository is created exclusively for educational, certification, and authorized security auditing purposes. Unauthorized testing of systems without explicit written consent is strictly illegal.

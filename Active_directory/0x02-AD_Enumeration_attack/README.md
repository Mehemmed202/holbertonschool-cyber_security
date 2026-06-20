# Active Directory Fundamentals & Offensive Reconnaissance Lab

## 1. Core Active Directory Concepts (What We Learned)

During this module, we covered the fundamental logical structures of Active Directory (AD) architecture:

* **Domain:** The primary security boundary in AD. It represents a logical grouping of network objects (users, computers, groups) that share a central directory database and common security policies, managed by a **Domain Controller (DC)**.
* **Tree:** A hierarchical collection of domains that share a contiguous DNS namespace (e.g., `baku.shirket.com` and `ganja.shirket.com` branching from the root `shirket.com`). Domains within a tree automatically establish two-way transitive trusts.
* **Forest:** The uppermost security boundary in Active Directory. It is a collection of one or more independent Domain Trees that share a common global catalog, directory schema, and logical configuration, allowing cross-domain resource access.
* **Organizational Unit (OU):** Sub-containers within a domain used to organize objects. Unlike standard containers, OUs allow administrators to link **Group Policy Objects (GPOs)** and delegate specific administrative controls to low-privilege users.

---

## 2. Vulnerability Breakdown: AS-REP Roasting

### The Logic
By default, Kerberos **Pre-Authentication** is enabled, requiring a client to encrypt a timestamp with their password hash before the Key Distribution Center (KDC) issues a Ticket Granting Ticket (TGT). This proves identity before a ticket is granted.

However, if an account is misconfigured with the `DONT_REQ_PREAUTH` (Do not require Kerberos preauthentication) flag enabled:
1. Anyone can send an unauthenticated **AS-REQ** message for that username.
2. The KDC immediately responds with an **AS-REP** packet containing a ticket partially encrypted with the target user's password hash.
3. An attacker can capture this packet and crack it offline without generating network noise or triggering account lockouts on the Domain Controller.

---

## 3. Practical Attack Execution Steps

### Step 1: Enumeration & Hash Extraction (`impacket-GetNPUsers`)
Using provided low-privileged student credentials (`student` / `Str0ngPass!2026`), we scan the Active Directory environment to query and extract the AS-REP hashes of all vulnerable accounts:

```bash
impacket-GetNPUsers -dc-ip <DC_IP> -request -format hashcat -outputfile hashes.txt domen.local/student:"Str0ngPass!2026"

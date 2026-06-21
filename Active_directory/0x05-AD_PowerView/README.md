# PowerView - Active Directory Enumeration & Reconnaissance

## Overview
PowerView is a powerful, PowerShell-based reconnaissance tool designed for Active Directory (AD) environments. It leverages Windows PowerShell to directly query Active Directory via LDAP (Lightweight Directory Access Protocol). Rather than relying on heavy graphical user interfaces (GUIs), PowerView allows security professionals, penetration testers, and Red Teamers to map out an AD environment with speed and precision directly from the command line.

This repository serves as a practical guide and reference manual for conducting domain enumeration, mapping Access Control Lists (ACLs), identifying misconfigurations, and understanding how defensive mechanisms like GPOs and Windows LAPS help mitigate these risks.

---

## Learning Objectives
By utilizing PowerView in AD engagements, you will learn how to:
* **Query Active Directory:** Understand how to extract information using native LDAP queries via PowerShell.
* **Domain Mapping:** Enumerate users, groups, computers, and Domain Controllers.
* **Identify Misconfigurations:** Detect dangerous ACL permissions such as `GenericAll`, `WriteDACL`, and `GenericWrite` on critical objects.
* **Analyze Group Policies:** Extract security configurations from Group Policy Objects (GPOs).
* **Assess Lateral Movement:** Discover local administrator access across different domain-joined machines.
* **Audit Trust Relationships:** Map trust boundaries between domains and forests.
* **Roasting Attacks:** Identify Kerberoastable and AS-REP Roastable accounts for credential escalation.

---

## Getting Started & Usage

Before executing PowerView, you must bypass the standard Windows PowerShell execution policy, which restricts unverified scripts from running. 

### 1. Bypass Execution Policy
Open PowerShell and run the following command to lift the restriction for your current terminal session:
```powershell
Set-ExecutionPolicy Bypass -Scope Process

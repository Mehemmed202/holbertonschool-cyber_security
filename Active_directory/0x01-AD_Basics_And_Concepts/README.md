# Active Directory Architecture and Adversarial Exploitation

## Introduction
This project-based module dives into the architecture and inner workings of Active Directory (AD) environments. The primary focus is understanding how Windows Server and Domain Controllers are structured, and how attackers leverage misconfigurations in Users, Groups, and Group Policy Objects (GPOs) to gain footholds, escalate privileges, and move laterally across enterprise networks. 

Throughout this lab, you will explore real-world AD environments, analyze trust relationships, abuse permission misconfigurations, and think like an adversary operating inside a corporate domain.

## Why It Matters
Active Directory is the backbone of identity and access management in over 90% of enterprise environments worldwide, making it the single most targeted infrastructure component in modern cyberattacks. From ransomware operators to nation-state threat actors, adversaries consistently target AD to escalate privileges, establish persistence, and compromise entire organizations in a matter of hours. 

Understanding how Domain Controllers are configured, how Users and Groups inherit permissions, and how GPOs can be weaponized is a foundational skill for any serious Red Teamer operating inside a corporate domain during penetration tests or assumed-breach simulations.

---

## Learning Objectives
By the end of this project, you should be able to comprehensively explain the following concepts without the assistance of external search engines:
* **Active Directory:** The centralized directory service used for identity and resource management.
* **Authentication:** The process of verifying identity ("Who are you?").
* **Authorization:** The process of verifying permissions and access rights ("What are you allowed to do?").
* **Domain Controllers (DC):** The core servers managing AD databases and security requests.
* **Domains:** The logical security boundaries sharing a common directory database.
* **LDAP (Lightweight Directory Access Protocol):** The protocol used to query and manage directory objects.

---

## Lab Architecture & Requirements

### Required Operating Systems
* **Attacker Machine:** Kali Linux
* **Victim Workstation:** Windows 11 Enterprise
* **Target Infrastructure:** Windows Server 2019 (Domain Controller)

### Network Configuration
> [!IMPORTANT]
> Connect all three Virtual Machines (Kali Linux, Windows 11, and Windows Server 2019) to the same isolated network network segment so they can communicate seamlessly. Do not modify any internal settings of the provided OVA files; import them exactly as-is.

### Connection & Target Credentials
* **Foothold Access:** Connect to the Windows workstation from Kali Linux using **WinRM**.
    * **Username:** `labuser`
    * **Password:** `P@ssw0rd123!`
* **The Golden Rule:** Students must only manually download and set up the Windows Server 2019 VM. Direct administrative access to the server is **not provided**. All administrative credentials and privileges on the Domain Controller must be obtained via systematic network enumeration and exploitation from the Kali Linux attack platform.

---

## General Requirements & Standards
* **Allowed Text Editors:** `vi`, `vim`, `emacs`
* **File Formatting:** All files within this repository must strictly end with a **new line** character.
* All attack simulations and enumeration work must originate exclusively from the Kali Linux instance targeting the Windows environment.

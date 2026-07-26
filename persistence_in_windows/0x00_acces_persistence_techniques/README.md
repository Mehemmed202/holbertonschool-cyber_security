# Windows Access Persistence Techniques

## Introduction
Gaining initial access to a target Windows machine is often temporary. A simple system reboot, network disconnection, or user logoff can immediately sever an attacker's session. **Persistence** is the phase in the cyber attack lifecycle where an adversary establishes mechanisms to maintain long-term access regardless of system state changes.

This project focuses on the hands-on exploration of Windows persistence techniques, demonstrating how adversaries leverage built-in operating system features to maintain continuous access without detection.

---

## Technical Overview of Persistence Mechanisms

### 1. Startup Folder
* **Concept:** Windows automatically executes all scripts, binaries, or shortcuts placed within the Startup folder upon user logon.
* **Paths:**
  * **Current User:** `%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup`
  * **All Users:** `%PROGRAMDATA%\Microsoft\Windows\Start Menu\Programs\Startup`
* **Mechanism:** Placing an executable or a `.lnk` file in these directories ensures execution every time an interactive user session begins.

### 2. Registry Run Keys
* **Concept:** The Windows Registry maintains specific keys designated for starting background processes or user applications at boot or logon.
* **Key Locations:**
  * `HKCU\Software\Microsoft\Windows\CurrentVersion\Run`
  * `HKLM\Software\Microsoft\Windows\CurrentVersion\Run`
  * `HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce`
* **Mechanism:** Creating a string value (`REG_SZ`) containing the path to a malicious executable triggers automated execution upon boot or login.

### 3. Scheduled Tasks (`schtasks`)
* **Concept:** The Windows Task Scheduler allows administrators and system processes to schedule automated tasks based on time intervals or specific triggers.
* **Triggers:** System startup (`ONSTART`), user logon (`ONLOGON`), idle state (`ONIDLE`), or scheduled times.
* **Mechanism:** Adversaries create hidden tasks via CLI (`schtasks /create`) or PowerShell to re-establish command-and-control (C2) connections periodically.

### 4. DLL Hijacking
* **Concept:** Windows applications rely on Dynamic-Link Libraries (DLLs) loaded at runtime. If an application searches for a required DLL using an incomplete search order, it can be abused.
* **Default DLL Search Order:**
  1. The directory from which the application loaded.
  2. The System directory (`C:\Windows\System32`).
  3. The 16-bit System directory.
  4. The Windows directory (`C:\Windows`).
  5. The current working directory.
  6. Directories listed in the `PATH` environment variable.
* **Mechanism:** Placing a malicious DLL with a legitimate name into a directory higher in the search order forces the legitimate process to execute arbitrary malicious code.
* **Mitigation:** Enforce Safe DLL Search Mode, verify DLL digital signatures, and use absolute paths in software development.

### 5. WMI Event Subscriptions
* **Concept:** Windows Management Instrumentation (WMI) can monitor system events and trigger actions when specific conditions are met.
* **Components:**
  * `__EventFilter`: WQL query defining the trigger event (e.g., system uptime, specific process launch).
  * `__EventConsumer`: Action to execute when triggered (e.g., `CommandLineEventConsumer`).
  * `__FilterToConsumerBinding`: Binds the filter to the consumer.
* **Mechanism:** Allows fileless persistence where malicious scripts reside directly within the WMI repository (`OBJECTS.DATA`).

### 6. BITS Jobs (Background Intelligent Transfer Service)
* **Concept:** BITS is a native Windows service used for background asynchronous file transfers (e.g., Windows Updates).
* **Mechanism:** BITS jobs can be created via `bitsadmin` or PowerShell to download payloads or execute commands upon transfer completion, operating stealthily in the background using minimal bandwidth.

---

## Defensive & Forensics Perspective

Detecting and mitigating persistence requires proactive monitoring of system configuration points:

* **Autoruns (Sysinternals):** Primary tool for inspecting startup locations, registry run keys, scheduled tasks, and services.
* **Event Logs Monitoring:**
  * **Event ID 4698:** Scheduled task created.
  * **Event ID 7045:** New service installed.
  * **Event ID 5861:** WMI Activity / Event Consumer creation.
* **Group Policy Restrictions:** Restrict unauthorized registry modifications and limit administrative permissions required for persistent installation.

---

## Recommended Learning Resources
* [MITRE ATT&CK - Persistence (TA0003)](https://attack.mitre.org/tactics/TA0003/)
* *Windows Internals* (Mark Russinovich, Pavel Yosifovich, Alex Ionescu, David A. Solomon)
* *The Art of Memory Forensics* (Michael Hale Ligh et al.)
* [Sysinternals Autoruns for Windows](https://learn.microsoft.com/en-us/sysinternals/downloads/autoruns)

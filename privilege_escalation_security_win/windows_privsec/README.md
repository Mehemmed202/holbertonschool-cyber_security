Windows Privilege Escalation: Core Concepts & Techniques

Welcome to this repository. This document serves as a comprehensive, technical reference guide covering the fundamental concepts, vectors, and mitigation strategies associated with Windows Privilege Escalation. It is structured around key learning objectives essential for red teamers, penetration testers, and security professionals specializing in Windows environment post-exploitation.
Table of Contents

    Introduction to Privilege Escalation

    Token Manipulation & SeImpersonatePrivilege

    DLL Hijacking

    Unquoted Service Paths

    Misconfigured Service Permissions

    Vulnerabilities in Scheduled Tasks & At Jobs

    Weak Registry Permissions

    Insecure File Permissions

    Bypassing User Account Control (UAC)

    Abusing Background Intelligent Transfer Service (BITS)

    Key Tools of the Trade

    Common Mitigation & Hardening Strategies

1. Introduction to Privilege Escalation
What It Is

Privilege escalation is the phase in a cyberattack where an adversary exploits flaws, misconfigurations, or design weaknesses within an operating system to elevate their current runtime context. Upon initial access, an attacker typically lands within a low-privileged context (e.g., a standard domain user or local service account). Privilege escalation involves moving vertically to achieve the highest possible administrative status, such as Administrator or NT AUTHORITY\SYSTEM.
Why It Is Important in Cybersecurity

Initial access rarely grants the permissions required to complete an operational objective. Without elevating privileges, an attacker faces severe functional constraints:

    Post-Exploitation Limits: Inability to dump credentials from memory (lsass.exe), modify system configurations, or disable security controls (AV/EDR).

    Lateral Movement Restrictions: High-level access is often mandatory to pivot across enterprise networks and access high-value targets.

    Lack of Persistence: Installing low-level hooks or persistent services typically requires administrative validation.

2. Token Manipulation & SeImpersonatePrivilege
Mechanism

Windows uses access tokens to identify the security context of a process or thread. These tokens contain the SID (Security Identifier), privileges, and logon session data. Security settings allow certain service accounts to act on behalf of other users via impersonation.
Exploitation

When an account possesses the SeImpersonatePrivilege (or SeAssignPrimaryTokenPrivilege), it has the right to impersonate a token once it is intercepted. Attackers exploit this by hosting a local server or named pipe and forcing a higher-privileged service (running as SYSTEM) to connect to it. Once the connection occurs, the attacker’s process captures the privilege token of the incoming SYSTEM connection, duplicates it, and spawns a new process (e.g., cmd.exe) executing entirely under that elevated token identity.
3. DLL Hijacking
Mechanism

Windows applications rely on Dynamic Link Libraries (DLLs) to execute modular pieces of code. When an application loads a DLL without specifying an absolute, fully qualified path, the OS searches for the file using a predefined sequence known as the DLL Search Order (e.g., the directory from which the application loaded, the current directory, System32, SysWOW64, and directories listed in the system PATH environment variable).
Exploitation

If a binary running with high privileges (SYSTEM or Administrator) attempts to load a missing or poorly specified DLL, and a low-privileged user has write permissions to any directory in the search order path before the legitimate DLL is found, exploitation is possible. The attacker drops a malicious, custom-compiled DLL using the exact name the binary is looking for into that writable directory. When the privileged application starts or executes the relevant function, it loads the attacker's DLL, executing arbitrary code within the high-privilege context.
4. Unquoted Service Paths
Mechanism

This vulnerability occurs when the executable path for a local Windows service contains spaces and is not wrapped in quotation marks (" ").
Exploitation

When interpreting an unquoted path containing spaces, the Windows Service Control Manager (SCM) attempts to parse the path step-by-step, treating the spaces as delimiters. For example, given the unquoted path:
C:\Program Files\Custom Application\Subfolder\service.exe

Windows will sequentially attempt to execute the following paths in order until a match is found:

    C:\Program.exe

    C:\Program Files\Custom.exe

    C:\Program Files\Custom Application\Subfolder\service.exe

If an attacker has write permissions to the root directory (C:\) or the C:\Program Files\ directory, they can place a malicious executable named Program.exe or Custom.exe. Upon the next service restart or system reboot, the SCM runs the attacker's binary instead of the intended application service binary.
5. Misconfigured Service Permissions
Mechanism

Every service in Windows is governed by an Access Control List (ACL) that controls which users or groups can modify its underlying parameters. Security principles dictate that low-privileged users should only have read or start capabilities, never modification rights.
Exploitation

If a service's security descriptor incorrectly grants standard users permissions like SERVICE_CHANGE_CONFIG or SERVICE_ALL_ACCESS, an attacker can reconfigure the service properties directly using built-in utilities (e.g., sc config). The attacker modifies the binpath (the parameter indicating which file the service executes) to point to their own malicious payload instead of the legitimate binary:
sc config <ServiceName> binpath= "C:\path\to\malicious.exe"

When the service is restarted, the Service Control Manager executes the malicious executable under the context assigned to that service (frequently NT AUTHORITY\SYSTEM).
6. Vulnerabilities in Scheduled Tasks & At Jobs
Mechanism

Scheduled Tasks and legacy at jobs allow administrators to automate execution routines. These tasks often run under elevated accounts or system identities to perform administrative tasks, updates, and synchronization.
Exploitation

Attackers look for flaws in how these tasks are configured:

    Weak File Permissions: If the script, binary, or batch file targeted by an elevated scheduled task sits in a directory where standard users possess write or modify permissions, an attacker can simply overwrite the file with a malicious version.

    Legacy At Jobs: On older Windows architectures, tasks configured using the legacy at command executed by default under the SYSTEM security context. Spawning an interactive command prompt via a vulnerable at job instantly resulted in a SYSTEM shell.

7. Weak Registry Permissions
Mechanism

The Windows Registry acts as the centralized configuration database for the operating system. Crucial service execution configurations, including binary paths, parameters, and startup options, are mapped inside HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services.
Exploitation

If the ACLs protecting specific registry keys associated with high-privilege services are misconfigured to allow low-privileged groups Write or Full Control access, attackers bypass service binary controls. The attacker edits the value of the ImagePath key for the target service, mapping it directly to their payload. Once the service restarts, the modified registry entry forces the system to load the attacker's file instead of the application.
8. Insecure File Permissions
Mechanism

File system security depends entirely on NT File System (NTFS) permissions. If directories hosting administrative tools, widely used system scripts, startup folders, or common binaries do not adhere to restricted access principles, they become insecure.
Exploitation

When standard users are granted Modify or Write access to critical application directories, attackers can weaponize the binaries residing inside them. They can:

    Replace a legitimate administrative tool with a Trojan horse version.

    Drop a malicious executable into the global Startup folder (C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp), which automatically executes the next time any user (including an Administrator) logs into the endpoint.

9. Bypassing User Account Control (UAC)
Mechanism

User Account Control (UAC) is a defense-in-depth security feature that forces accounts belonging to the local Administrators group to run tasks using a filtered, low-privileged token (Medium Integrity) by default. When an administrative action is requested, UAC prompts the user for confirmation before escalating to a High Integrity token.
Exploitation

Attackers who have achieved a footprint inside an administrative account operating in a Medium Integrity shell must bypass the UAC prompt to execute commands with true administrative rights. They target built-in, trusted Windows binaries designed to auto-elevate (e.g., fodhelper.exe, computerdefaults.exe). These binaries bypass the visual UAC prompt because they are digitally signed by Microsoft. Attackers manipulate the registry keys or environmental structures these trusted binaries query upon startup, redirecting the auto-elevating binary to launch a custom malicious payload silently in a High Integrity context.
10. Abusing Background Intelligent Transfer Service (BITS)
Mechanism

The Background Intelligent Transfer Service (BITS) is a native Windows component designed to facilitate asynchronous, throttled file uploads and downloads between machines using idle network bandwidth. BITS operates as a service running natively under the NT AUTHORITY\SYSTEM context.
Exploitation

Attackers interact with BITS using the bitsadmin tool or PowerShell cmdlets to create specific "BITS Jobs". A native feature of BITS allows users to specify a notification command or executable to run automatically as soon as a file transfer job finishes or hits an error state. Because the underlying execution infrastructure is managed entirely by the BITS service, the specified notification command executes directly with elevated SYSTEM privileges. This mechanism is frequently leveraged both for privilege escalation and for achieving persistent backdoor execution.
11. Key Tools of the Trade

    JuicyPotato (and the Potato Family): A renowned class of local privilege escalation exploits designed to weaponize SeImpersonatePrivilege or SeAssignPrimaryTokenPrivilege. They work by abusing local COM/OLE structures and named pipes to intercept and spoof elevated tokens, forcing a transition from local service accounts straight to SYSTEM.

    Mimikatz: A post-exploitation tool primarily utilized to extract plaintext credentials, NTLM hashes, Kerberos tickets, and PIN codes from the memory space of the Local Security Authority Subsystem Service (lsass.exe). It also contains extensive capabilities for token manipulation, Pass-the-Hash, and Pass-the-Ticket attacks.

    WinPEAS & PowerUp.ps1 (Enumeration Frameworks): Automated scripts crucial for the privilege escalation lifecycle. They rapidly parse the target Windows operating system to locate all the misconfigured vectors described above, including unquoted paths, weak ACLs, missing patches, and vulnerable registry keys.

12. Common Mitigation & Hardening Strategies

Securing a Windows environment against privilege escalation requires applying a rigorous defense-in-depth model across configurations, file systems, and user controls:

    Enforce the Principle of Least Privilege (PoLP): Restrict standard users and service accounts to the absolute minimum permissions required to perform their routine duties.

    Sanitize Service Executable Paths: Ensure that all defined paths inside the Service Control Manager are cleanly wrapped in quotation marks to fully mitigate Unquoted Service Path flaws.

    Audit and Harden ACLs: Periodically review file system, registry, and service security descriptors. Ensure standard users never possess write or modify rights over system binaries, configurations, or startup directories.

    Maximize UAC Policies: Configure User Account Control to its highest enforcement setting ("Always Notify") and ensure administrative accounts are segregated from standard user tasks.

    Isolate Service Accounts: Move away from running services under generic SYSTEM or local Administrator identities. Implement Managed Service Accounts (MSAs) or low-privilege dedicated service identities (LocalService/NetworkService).

    Robust Patch Management: Routinely deploy security updates, cumulative rollups, and kernel hotfixes to close public vulnerabilities impacting OS components like BITS, the Win32k subsystem, or active device drivers.

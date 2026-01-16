# Web Application Security – 0x00 Web Fundamentals

## Description
This project focuses on understanding and exploiting common web application vulnerabilities.
The target application is a Customer Support Dashboard that was claimed to be "hack-proof"
and developed in a very short time using AI-assisted code generation.

The objective of this task is to demonstrate that applications built quickly or with the
help of AI can still contain serious security vulnerabilities and must be properly tested.

---

## Environment
- Operating System: Kali Linux
- Browser: Firefox
- Tools:
  - curl
  - sqlmap
- Network Access: OpenVPN / Sandbox

---

## Target Information
- Domain: web0x00.hbtn
- Login Endpoint: http://web0x00.hbtn/login

The domain name was mapped to the target machine IP using the `/etc/hosts` file.

Example:

<Target_IP> web0x00.hbtn


---

## Connectivity Test

### Via Terminal

curl http://web0x00.hbtn


The server responds with a redirection to `/home`, confirming that the target is reachable.

### Via Browser
Accessing `http://web0x00.hbtn/login` through Firefox successfully loads the login page.

---

## Methodology
1. Configured local name resolution using `/etc/hosts`
2. Verified connectivity using curl and browser
3. Performed reconnaissance on the login endpoint
4. Inspected HTTP requests using browser developer tools
5. Conducted manual input testing
6. Used automated tools to confirm vulnerabilities

---

## Vulnerability Analysis

### Vulnerability Type
- SQL Injection

### Location
- Login form (`/login` endpoint)

### Description
The login functionality does not properly validate or sanitize user input.
This allows malicious SQL payloads to be injected into the authentication query,
making it possible to bypass authentication controls.

---

## Exploitation

Manual testing of the login form with crafted input demonstrated that authentication
could be bypassed.

Automated confirmation was performed using `sqlmap`, which successfully identified
the injection point and confirmed the vulnerability.

Example tool used:

sqlmap


---

## Result
Unauthorized access to the application was achieved by exploiting the SQL Injection
vulnerability. This proves that the application is not secure and is vulnerable to
basic web attacks.

---

## Conclusion
This project highlights the importance of proper security testing in web applications.
Even when applications are developed using modern tools or AI-assisted code generation,
security vulnerabilities can still exist.

Regular penetration testing and secure coding practices are essential to protect
web applications from common attacks.

---

## Disclaimer
This project was conducted in a controlled lab environment for educational purposes only.
Unauthorized testing of systems without permission is illegal.


# Server-Side Request Forgery (SSRF) Guide

This repository/guide provides a comprehensive overview of Server-Side Request Forgery (SSRF), covering fundamental concepts, attack mechanisms, and defense strategies.

## Table of Contents
- [What is SSRF?](#what-is-ssrf)
- [How Does SSRF Work?](#how-does-ssrf-work)
- [SSRF Attack Types](#ssrf-attack-types)
- [Impact and Risks](#impact-and-risks)
- [Common Attack Scenarios](#common-attack-scenarios)
- [Defense and Prevention](#defense-and-prevention)

## What is SSRF?
Server-Side Request Forgery (SSRF) is a security vulnerability that allows an attacker to induce the server-side application to make HTTP requests to an arbitrary domain or internal service.

## How Does SSRF Work?
Many web applications interact with external services or allow user input to fetch resources (e.g., uploading profile pictures from URLs). If the application fails to validate or sanitize the user-supplied URL, an attacker can manipulate the input to point to unintended targets, such as internal network addresses or the local host itself.

## SSRF Attack Types
- **Standard (In-band) SSRF:** The response from the target server is returned directly to the attacker.
- **Blind SSRF:** The server processes the request but does not return the response, requiring the attacker to monitor out-of-band interactions or time delays.

## Impact and Risks
- **Access to Internal Services:** Ability to interact with internal-only services or APIs (e.g., `127.0.0.1:22` or databases).
- **Data Exfiltration:** Accessing sensitive internal documentation or configuration data.
- **Port Scanning:** Using the vulnerable server to map the internal network.
- **Cloud Metadata Access:** Extracting sensitive credentials or IAM tokens from cloud environment metadata endpoints (e.g., `http://169.254.169.254/`).

## Common Attack Scenarios
1. **Internal Port Scanning:** Sending requests to `http://localhost:<port>` to identify open internal ports.
2. **Metadata Endpoint Targeting:** Accessing `http://169.254.169.254/latest/latest/meta-data` in cloud environments.
3. **Local File Access:** Using the `file:///` URI scheme if supported by the application.

## Defense and Prevention
- **Input Validation:** Use strict allowlists (whitelists) for URLs and domains.
- **Protocol Whitelisting:** Allow only `http` and `https`. Disable schemes like `file://`, `gopher://`, or `dict://`.
- **Disable Internal Network Access:** Block requests to private IP ranges (e.g., `10.0.0.0/8`, `172.16.0.0/12`, `192.168.0.0/16`, and `127.0.0.0/8`).
- **Response Handling:** Hide raw error messages from the application to prevent information leakage about the internal network.
- **Network Segmentation:** Place the web server in a DMZ or isolated network segment.


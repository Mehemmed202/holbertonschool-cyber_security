# Reverse Engineering & ELF Binary Structure Fundamentals

A comprehensive technical reference guide covering software reverse engineering principles, memory segmentation, Linux analysis tools, and the internal architecture of Executable and Linkable Format (ELF) binaries.

---

## 📋 Table of Contents
- [1. Introduction to Reverse Engineering](#1-introduction-to-reverse-engineering)
- [2. Real-World Case Study](#2-real-world-case-study)
- [3. Memory Segments](#3-memory-segments)
- [4. Essential Analysis Tools](#4-essential-analysis-tools)
- [5. ELF Binary Architecture](#5-elf-binary-architecture)
- [6. Core Concepts & Q&A](#6-core-concepts--qa)

---

## 1. Introduction to Reverse Engineering

> *"Every program tells a story. Reverse engineering is how you learn to read it."*

Modern software runs on a wide variety of hardware—from servers and personal computers to mobile devices and embedded IoT platforms. In many security and auditing scenarios, source code is unavailable. Reverse Engineering (RE) is the process of analyzing a compiled binary to reconstruct its logic, execution flow, and underlying system behavior.

### Core Applications
* **Malware Analysis:** Deconstruct malicious binaries to extract Command & Control (C2) servers, encryption keys, and persistence mechanisms.
* **Vulnerability Research:** Analyze binaries for memory corruptions, logic flaws, or buffer overflows to develop patches.
* **Software Compatibility & Interoperability:** Re-engineer closed protocols or driver interfaces for legacy/third-party systems.

---

## 2. Real-World Case Study

During a routine security assessment, an enterprise discovered an undocumented background process executing on a production server. While no alerts were triggered by standard monitoring, unusual outbound network traffic was logged.

By performing static and dynamic reverse engineering, security analysts isolated hidden routines that were harvesting system metadata and exfiltrating it to an unauthenticated external endpoint—a risk completely invisible to higher-level application logs.

---

## 3. Memory Segments

When an executable is loaded into system memory (RAM), its data and instructions are organized into distinct functional sections:

| Segment | Purpose | Access Permissions | Storage on Disk |
| :--- | :--- | :--- | :--- |
| **`.text`** | Contains executable machine code (instructions). | `Read + Execute` | Yes |
| **`.rodata`** | Read-only data (string literals, constants). | `Read-Only` | Yes |
| **`.data`** | Initialized global and static variables. | `Read + Write` | Yes |
| **`.bss`** | Uninitialized global/static variables (zero-filled at runtime). | `Read + Write` | No (Allocated in RAM) |

---

## 4. Essential Analysis Tools

### Binary Sections for Dynamic Linking
* **`.dynsym` (Dynamic Symbol Table):** Contains exported and imported function/variable names required for runtime linking (e.g., `printf`, `malloc`). Unlike `.symtab`, it is not removed by the `strip` command.
* **`.plt` (Procedure Linkage Table):** Serves as a stub/bridge to resolve dynamic library calls at runtime via the Global Offset Table (`.got`).

### Command-Line Analysis Tools
* **`strings`:** Extracts readable ASCII and Unicode text (URLs, flags, hardcoded keys) embedded in binaries.
* **`readelf`:** Parses ELF file headers, section headers, and dynamic symbols.
* **`objdump`:** Disassembles machine code into Assembly language and inspects binary headers.
* **`nm`:** Displays symbol tables (function names, variable addresses).
* **`gdb`:** GNU Debugger used for dynamic analysis (setting breakpoints, memory inspection, and register tracking).

---

## 5. ELF Binary Architecture

**ELF (Executable and Linkable Format)** is the standard binary format for Linux, Unix-like OS, Android, and embedded platforms.

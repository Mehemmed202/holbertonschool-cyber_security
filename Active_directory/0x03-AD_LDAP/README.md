# 🛠️ Active Directory Enumeration Handbook: ldapsearch & crackmapexec

This handbook serves as a quick-reference guide for using `ldapsearch` and `crackmapexec` (netexec) during the initial phases of an Active Directory security assessment.

---

## 📖 Table of Contents
1. [LDAP Enumeration (ldapsearch)](#1-ldap-enumeration-ldapsearch)
   - [Basic Syntax & Operators](#basic-syntax--operators)
   - [Practical Query Examples](#practical-query-examples)
2. [SMB & Domain Enumeration (crackmapexec)](#2-smb--domain-enumeration-crackmapexec)
   - [Basic Syntax & Protocols](#basic-syntax--protocols)
   - [Practical Exploitation Commands](#practical-exploitation-commands)
3. [Cheatsheet Reference Matrix](#3-cheatsheet-reference-matrix)

---

## 1. LDAP Enumeration (ldapsearch)

`ldapsearch` is a powerful tool used to query the Lightweight Directory Access Protocol (LDAP) service (Ports `389` / `636`). It allows you to extract the entire Active Directory database structure, including user objects, group memberships, and descriptions.

### Basic Syntax & Operators

```bash
ldapsearch -x -H ldap://

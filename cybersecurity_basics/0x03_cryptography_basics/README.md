# Cryptography & Password Cracking Essentials

This project covers the fundamentals of cryptography in cybersecurity, ranging from theoretical concepts like encryption/decryption to practical password recovery using industry-standard tools like **John the Ripper** and **hashcat**.

---

## 🛡️ Core Concepts

### What is Cryptography?
In cybersecurity, **cryptography** is the practice of securing information by transforming it into an unreadable format, ensuring that only authorized parties can access it.

* **Encryption:** The process of converting plain text into an unreadable format (Ciphertext).
* **Decryption:** The process of converting ciphertext back into its original form (Plaintext).

### Importance & Applications
Cryptography is the backbone of digital privacy. It provides:
1.  **Confidentiality:** Only the intended recipient can read the data.
2.  **Integrity:** Ensures data hasn't been altered during transit.
3.  **Authentication:** Verifies the identity of the sender.
4.  **Non-repudiation:** Prevents a sender from denying they sent a message.

**Applications:** Secure web browsing (HTTPS), Disk encryption (BitLocker), Secure messaging (WhatsApp), and Digital Signatures.

---

## 🔑 Types of Cryptography

| Type | Description | Common Algorithms |
| :--- | :--- | :--- |
| **Symmetric** | Same key for both encryption and decryption. | AES, DES |
| **Asymmetric** | Uses a Public key (encryption) and a Private key (decryption). | RSA, ECC |
| **Hashing** | One-way transformation to a fixed-length string. | SHA-256, MD5 |

---

## 🧩 Hashing and SHA
* **Hash Algorithm:** A mathematical function that converts an input of any size into a fixed-length string of characters. It is a "one-way" process.
* **SHA (Secure Hash Algorithm):** A family of cryptographic hash functions published by NIST. For example, SHA-256 generates a unique 256-bit (64-character) signature for any data.

---

## 🛠️ Tools of the Trade

### 1. John the Ripper (JtR)
A versatile, multi-platform password cracker often used for CPU-based cracking and identifying unknown hash formats.
* **Basic Usage:** `john --wordlist=pass.txt hash_file.txt`
* **Advanced Cracking:** Use `ssh2john` or `zip2john` to extract hashes from protected files, then crack them with custom rules.

### 2. Hashcat
Known as the world's fastest password cracker, it leverages the power of the **GPU** to process billions of hashes per second.
* **Attack Modes (`-a`):**
    * `-a 0`: Straight (Wordlist)
    * `-a 1`: Combinator (Combines two wordlists)
    * `-a 3`: Mask (Brute-force with patterns)
* **Hash Types (`-m`):** Specifies the algorithm (e.g., `-m 0` for MD5, `-m 1800` for SHA-512).

---

## 🎓 Learning Objectives Summary
By the end of this study, you should be able to:
- Explain the difference between encryption and hashing.
- Identify hash formats manually or using tools.
- Utilize **OpenSSL** for basic cryptographic operations.
- Execute successful dictionary and brute-force attacks using **John** and **hashcat**.

---

## 📚 References
- [John the Ripper Documentation](https://www.openwall.com/john/)
- [Hashcat Wiki](https://hashcat.net/wiki/)
- [OpenSSL Official Site](https://www.openssl.org/)

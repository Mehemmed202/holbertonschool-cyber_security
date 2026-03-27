🛡️ Understanding IDOR: Insecure Direct Object Reference
📝 Description

Insecure Direct Object Reference (IDOR) is a type of access control vulnerability that occurs when an application uses user-supplied input to access objects directly without sufficient authorization checks.

In simpler terms, if a user can change a parameter value (like an ID, filename, or key) in a request to access data belonging to another user, the application is vulnerable to IDOR.
🚀 How IDOR Works (Attack Scenario)

    Discovery: The attacker identifies an API endpoint or URL that uses an identifier to fetch data (e.g., GET /api/user/123).

    Analysis: The attacker notices that the ID 123 is predictable (numeric or sequential).

    Manipulation: The attacker intercepts the request (using tools like Burp Suite) and changes the ID to 124.

    Exploitation: If the server fails to verify if the current session owner has permission to view ID 124, it returns the sensitive data of the second user.

🛠️ Practical Examples
1. URL Parameter Manipulation

    Original Request: https://bank.com/view_invoice?id=5001 (User views their own invoice)

    Malicious Request: https://bank.com/view_invoice?id=5002 (Attacker views someone else's invoice)

2. Body Parameter Manipulation (POST/PUT)

Even if the ID is not in the URL, it might be in the JSON body:
JSON

// Original Request (Update my profile)
{
  "user_id": "88a1",
  "email": "my-email@example.com"
}

// Malicious Request (Update Victim's profile)
{
  "user_id": "88a2", 
  "email": "hacker@evil.com"
}

🔍 Detection Techniques

    Manual Testing: Capture requests in Burp Suite and manually increment/decrement ID values.

    Predictable IDs: Look for patterns. If you see id=100, try 99 or 101.

    Parameter Discovery: Try adding common parameters to URLs, such as ?user_id=, ?account=, or ?doc_id=.

    Horizontal vs. Vertical: * Horizontal: Accessing data of a user with the same privilege level.

        Vertical: Accessing data of a user with higher privilege (e.g., an Admin).

🛡️ Prevention & Best Practices

    Implement Object-Level Authorization: This is the gold standard. Every single request must check: "Does User A have the right to access Object B?"

    Use Non-Predictable Identifiers (UUIDs): Instead of id=1, use id=ebc44aef-25fc-4adf-a847-3bdc46911d65. This makes it impossible for an attacker to guess other IDs.

    Use Indirect References: Map internal database IDs to temporary, random strings that are only valid for that specific session.

    Input Validation: Ensure that the supplied ID conforms to the expected format and type.

🔗 Learning Resources

    OWASP Top 10: Broken Access Control

    PortSwigger Web Security Academy - IDOR

Disclaimer: This documentation is for educational and ethical security testing purposes only. Unauthorized access to computer systems is illegal.

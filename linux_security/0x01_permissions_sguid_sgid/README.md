Here is a comprehensive, professionally structured README.md file in English that covers all the learning objectives and commands you've requested.
Linux Permissions and User Management

This project covers the fundamental concepts of Linux file permissions, special bits, and user/group administration. Understanding these is critical for system security and effective administration.
🎯 Learning Objectives

By the end of this project, you should be able to explain:

    The three user-based permission groups.

    The function of core commands: chmod, sudo, su, chown, and chgrp.

    The purpose and usage of SUID and SGID.

    The difference between chown and chgrp.

    Best practices for security and auditing.

    The concept of Umask.

1. User-Based Permission Groups

Every file and directory in Linux is assigned to three types of owners:

    User (u): The individual who owns the file (usually the creator).

    Group (g): A collection of users who share the same permissions for the file.

    Others (o): Every other user on the system who is not the owner or a member of the group.

2. Command Reference Table
Command	Description	Example
chmod	Changes file/directory permissions (Mode).	chmod 755 script.sh
sudo	Executes a command with superuser (root) privileges.	sudo apt update
su	Switches to another user account.	su - username
chown	Changes the owner and/or group of a file.	chown user:group file.txt
chgrp	Changes only the group ownership of a file.	chgrp developers file.txt
id	Prints real and effective user and group IDs.	id root
groups	Lists the groups a user belongs to.	groups alice
useradd	Low-level utility for adding users.	useradd -m bob
adduser	Interactive, user-friendly script to add users.	adduser bob
addgroup	Adds a new group to the system.	addgroup admins
3. Special Permissions: SUID and SGID
SUID (Set User ID)

    Purpose: Allows a user to execute a file with the permissions of the file owner.

    Symbol: Represented by an s in the user's execution bit (e.g., -rwsr-xr-x).

    Usage: chmod u+s file_name

SGID (Set Group ID)

    On Files: Executes the file with the permissions of the group owner.

    On Directories: Any new file created inside the directory inherits the group of the parent directory, rather than the group of the user who created it.

    Usage: chmod g+s directory_name

4. Understanding Umask

Umask (User Mask) defines the default permissions for newly created files and directories. It acts as a filter that "subtracts" permissions from the system maximums.

    Max for Directories: 777

    Max for Files: 666

    Calculation: Default=Max−Umask

        Example: If umask is 022, a new directory gets 755 (777−022) and a new file gets 644 (666−022).

5. Best Practices & Auditing

    Principle of Least Privilege: Never give more permissions than necessary. Avoid chmod 777.

    Use sudo instead of su: This allows for better logging and avoids sharing the root password.

    The Sticky Bit: Use chmod +t on shared directories (like /tmp) so users can only delete their own files.

    Auditing: * Monitor /var/log/auth.log or /var/log/secure to track sudo usage.

        Use the auditd daemon to track specific file permission changes in real-time.

6. /etc/passwd Structure

The file follows this specific 7-field format: Username : Password(x) : UID : GID : Comment : Home Directory : Shell

    Note: The difference between chown and chgrp is that chown can change both the owner and the group, whereas chgrp is strictly limited to changing the group ownership.

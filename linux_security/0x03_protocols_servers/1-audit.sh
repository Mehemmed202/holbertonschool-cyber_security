#!/bin/bash
find /etc/ssh/sshd_config -exec grep -v "^#" {} + -exec ls {} + 2>/dev/null

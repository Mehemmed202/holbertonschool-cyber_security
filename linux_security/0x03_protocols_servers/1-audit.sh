#!/bin/bash
find /etc/ssh/sshd_config -exec grep -Ev "^#" {} + -exec ls {} + 2>/dev/null

#!/bin/bash
find / -xdev -perm -0002 -type d -exec chmod 000 {} + 2>/dev/null

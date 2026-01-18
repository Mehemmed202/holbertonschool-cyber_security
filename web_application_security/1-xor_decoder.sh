#!/bin/bash
input_hash=$(echo "$1" | sed 's/{xor}//')
echo "$input_hash" | base64 -d | python3 -c "
import sys
for b in sys.stdin.buffer.read():
    print(chr(b ^ 95), end='')
print()
"

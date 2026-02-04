#!/bin/bash
john $1 --format=raw-sha256 --wordlist=/usr/share/wordlists/rockyou.txt

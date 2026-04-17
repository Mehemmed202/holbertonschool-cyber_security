#!/bin/bash
tail -n 1000 auth.log | grep -i "sudo:session" | awk '{print $11}' | sort | uniq -c | awk '{print $2}'

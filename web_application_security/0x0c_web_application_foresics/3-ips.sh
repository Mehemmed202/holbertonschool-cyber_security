#!/bin/bash
grep -i "accepted" auth.log | grep "root" | awk '{print $11}' | sort | uniq -c | wc -l 

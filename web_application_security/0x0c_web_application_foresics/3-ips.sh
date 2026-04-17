#!/bin/bash
grep -i "accepted" auth.log | awk '{print $11}' | sort | uniq -c | wc -l

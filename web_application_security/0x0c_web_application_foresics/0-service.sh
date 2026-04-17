#!/bin/bash
awk '{print $6}' auth.log | grep -oP '\(\K[^:]+' | sort | uniq -c | sort -nr

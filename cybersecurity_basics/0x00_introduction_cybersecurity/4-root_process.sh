#!/bin/bash
ps aux -u "$1" | grep -v "^vzs" | grep -v "^rss" | grep -v " 0.0 0.0 "

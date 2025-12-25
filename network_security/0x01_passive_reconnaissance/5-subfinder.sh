#!/bin/bash
dom="$1"
subfinder -d "$1" >> $dom.txt

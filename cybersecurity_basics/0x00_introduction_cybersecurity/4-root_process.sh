#!/bin/bash
ps aux -u "$1" | grep -v " 0.0 0.0 "

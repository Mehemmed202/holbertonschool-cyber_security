#!/bin/bash
ps aux -u "$1" u | grep -v " 0.0 0.0 "

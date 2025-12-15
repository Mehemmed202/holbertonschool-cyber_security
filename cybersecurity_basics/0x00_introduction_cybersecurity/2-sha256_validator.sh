#!/bin/bash
echo "$(md5sum "$1" | cut -d' ' -f1)"

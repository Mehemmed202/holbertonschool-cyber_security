#!/bin/bash
echo "$(sha256sum "$1" | cut -d' ' -f1)"

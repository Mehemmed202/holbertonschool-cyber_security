#!/bin/bash
find $1 -empty -exec chmod 777 {} + -type f

#!/bin/bash

clear

dir="check"

find "$dir" -type f -exec rm {} \;

echo "Files cleaned up from $dir..."

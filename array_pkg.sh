#!/bin/bash

clear

package=(git unzip curl)

for pkg in "${package[@]}"
do
    sudo apt install "$pkg" -y
done
echo "packages installed successfully..."

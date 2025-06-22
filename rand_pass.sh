#!/bin/bash

length=12
p=$(openssl rand -base64 "$length")
echo "Generated password : $p"

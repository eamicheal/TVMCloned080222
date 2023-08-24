#!/bin/bash

# Update package lists
sudo apt-get update
sudo apt-get update -y 

# Install required packages via apt-get including LLVM
# sudo apt-get install -y python3 python3-dev python3-setuptools gcc build-essential cmake libtinfo-dev zlib1g-dev libedit-dev libxml2-dev llvm-4.0
sudo apt-get install -y python3 python3-dev python3-setuptools gcc build-essential cmake libtinfo-dev zlib1g-dev libedit-dev libxml2-dev python3.7 llvm-4.0

# Get TVM via Git
# git clone --recursive https://github.com/eamicheal/TVMCloned080222 tvm
git clone --recursive https://github.com/eamicheal/tvmcloned020822 tvm

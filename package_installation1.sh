#!/bin/bash

# Update package lists
sudo apt-get update
sudo apt-get update -y

# Install required packages via apt-get
sudo apt-get install -y python3-cloudpickle python3-sklearn git

# Upgrade packages via pip3 --- remove sklearn and use scikit-learn
pip3 install --upgrade plotly==3.10.0 typing-extensions numpy pandas==1.1.5 wheel scipy scikit-learn openpyxl xgboost

# Install PyTorch
pip3 install --upgrade torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cpu

# Additional step for scikit-learn
pip3 install -U scikit-learn


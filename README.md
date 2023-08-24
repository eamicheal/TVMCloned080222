# INSTRUCTION
## INSTALL Dependency PACKAGES FOR TVM
```
cp -a /package_installation.sh/. /home/xilinx/package_installation.sh
chmod +x package_installation.sh
# sudo ./package_installation.sh
./package_installation.sh

```

## MAKE TVM FOR CPU SIM Environment
1. prepare for make
```
cd tvm/
mkdir build
cp cmake/config.cmake build
nano build/config.cmake
```

2. Update on the make file in TVM build folder. In config.cmake set these variables to ON or OFF:
• set(USE_LLVM ON)
• set(USE_VTA_FSIM ON)
• set(USE_VTA_FPGA OFF)

3. To use the CMAKE builder, make TVM (Process takes about 5 hours)
```
export TVM_LOG_DEBUG=1
cd build
cmake ..
make -j2
```


4. Export 7 Variables (in the terminal and in ~/.bashrc) for standard install location:

## INSTALL PACKAGES FOR THE NN Environment
```
nano .bashrc

```
1. export TVM_HOME=/home/xilinx/tvm
2. export TVM_PATH=/home/xilinx/tvm
3. export PYTHONPATH=$TVM_HOME/python:${PYTHONPATH}
4. export VTA_HW_PATH=$TVM_PATH/3rdparty/vta-hw
5. export PYTHONPATH=/home/xilinx/tvm/vta/python:${PYTHONPATH}

6. export PYTHONPATH=/home/xilinx/.local/bin:${PYTHONPATH}
7. export PATH=$PATH:/home/xilinx/.local/bin

```
source .bashrc

```
4. Setup & Install TVM Python dependencies
```
cd tvm/
cd python; python3 setup.py install --user; cd ..
```
   
## INSTALL PACKAGES FOR THE NN Environment
```
cp -a /package_installation1.sh/. /home/xilinx/package_installation1.sh
chmod +x package_installation1.sh
sudo ./package_installation1.sh

```

IF ERROR: No module name tvm
update and source .bashrc

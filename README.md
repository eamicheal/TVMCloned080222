# KIRETT
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

export TVM_HOME=/home/xilinx/tvm
export TVM_PATH=/home/xilinx/tvm
export PYTHONPATH=$TVM_HOME/python:${PYTHONPATH}
export VTA_HW_PATH=$TVM_PATH/3rdparty/vta-hw
export PYTHONPATH=/home/xilinx/tvm/vta/python:${PYTHONPATH}

export PYTHONPATH=/home/xilinx/.local/bin:${PYTHONPATH}
export PATH=$PATH:/home/xilinx/.local/bin

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



## How to setup the wifi-usb-dongle (OPTIONAl)

This Setup was based on a Tutorial of [Electronics Hub](https://www.electronicshub.org/setup-wifi-raspberry-pi-2-using-usb-dongle/). For full view, look into the link.

### Requirments
1. Install [mobaxterm](https://mobaxterm.mobatek.net/download-home-edition.html) or any other tool to connect your board with COM-Option.
2. Check if you have access to the Linux environemnt via mobaxterm and you can login into the board. 
3. The credentials are:
```
Username: xilinx
Password: xilinx
```

### Hardware Connection
1. Turn your Hardware off, by unplugging it from the board. 
2. Connect the USB Wifi Dongle to the USB Port
3. Connect the USB 

### Check for detection of the dongle
If you want to check, wether the board has successfully recognize the Wifi Adapter, use the following command and find 
```
dmesg | more
```
Hit spacebar multiple times to jump to the next page of the list. There should be something similiar to the following list:

```
[8.947337] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[8.954470] usb 1-1: Product: 802.11n WLAN Adapter
[8.959257] usb 1-1: Manufacturer: Realtek
[8.963353] usb 1-1: SerialNumber: 00e04c000001
[9.396404] systemd[1]: System time before build time, advancing clock.
[9.429010] systemd[1]: systemd 237 running in system mode. (+PAM +AUDIT +SEL
```

This means, that your board has detected the USB Wifi Dongle. But the Dongle does not work yes as we need to configure it.

## Method 1 (Recommended): 
Configuration with Pynq

### Configuring

Execute the following lines in python interpreter:

```
from pynq.lib import Wifi

w = Wifi()
w.connect("SSID", "PWD")
```
Here `SSID` is your WiFi name and `PWD` is the password. Please replace them with yours. 

### Verifying

Once executing the script, you can have a look at the Wlan stored configurations in 

```
cat /etc/network/interfaces.d/wlan0
```

Now you have to reboot the system and your linux would be automatically connected to the wifi after the restart.




## Method 2: 
Manual Configuration

### Phase 1: Edit the Network Interfaces File
We now need to edit the network interfaces file that is located in ```etc/network/interfaces```. This file sets up the Wifi Dongle we are going to use. In order to open the network interfaces file, type the following comamand and hit enter:
```
sudo nano /etc/network/interfaces
```
After you have entered your password (optional) a file will open. This file can already have some lines. Regardless to that, you need to add the following lines of code to the existing one:
To do that: copy the lines of code and hit ```i``` to enable the editing mode of vim. Then paste the code inside the terminal:

```
auto lo
iface lo inet loopback
iface eth0 inet manual
auto wlan0
allow-hotplug wlan0
iface wlan0 inet manual
wpa-roam /etc/wpa_supplicant/wpa_supplicant.conf
```

The line ```iface eth0 inet manual``` can be deleted for the current time beeing, because we are trying to connect the Wifi Dongle and dont want linux to try to connect the Ethernet environment.

```
auto lo
iface lo inet loopback
auto wlan0
allow-hotplug wlan0
iface wlan0 inet manual
wpa-roam /etc/wpa_supplicant/wpa_supplicant.conf
```

Now hit the ```ESC```-Button and then type ```:wq``` to write the lines of code in the the file and close it.

### Phase 2: Edit the WPA Supplicant File
The WPA or WiFi Protected Access Supplicant file consists of the details regarding the WiFi network like the name, password, security, type etc.  We need to edit this file and add the details of your personal WiFi network. In order to open the WPA Supplicant File, type the following command and hit enter.

```
sudo nano /etc/wpa_supplicant/wpa_supplicant.conf
```

Add the following lines of code to the existing code (if any). Change the Wifi Network Details as needed. For that hit ```i``` and paste the code into it

<span style="color: red"> IMPORTANT: The connection with the University of Siegen Environment does not work at the current moment. Please be informed, that this tutorial was tested on a mobile Hotspot Environment. </span>

```
network={
ssid="Name of WiFi Network"
psk="Password of the WiFi Network"
proto=RSN
key_mgmt=WPA-PSK
pairwise=CCMP TKIP
group=CCMP TKIP
id_str="Name of WiFi Network"
}
```

In order to write and close vim. Hit ```ESC```-Button and write ```:wq```.

### Phase 3: Reboot your Board
After you have successfully done the before mentioned phases, you can simply reboot the board, by using the following command 
```
sudo poweroff
```
Afterwards, unplug your device and plug it again, so the reboot can be initiated.

### Phase 4: Check if device show ESSID
With the following command, you can check, wether the ESSID is mentioned or not.
```
iwlist wlan0 scan | grep ESSID
```

After this you will hopefully see the connected ESSID. 

### Phase 5: Set-up dynamic IP
Use the following command to enable a dynamic IP:
```
sudo dhclient wlan0
```
Afterwards use the following command to check, if you can now see your ipv6-Adress, which can be used for the ssh-call:
```
ifconfig
```

### Phase 6: Use mobaxterm for ssh connection:
If the IPv6 Adress is showing, simple go to mobaxterm and start a new ssh-session with the given IP-Adress. It should connect flawlessly.


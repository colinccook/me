# Raspberry Pi Setup Guide

The following instructions have been written myself to help in setting up a Raspberry Pi. 

You can mix and match the identified sections below depending on the tasks you wish your Pi to perform.

### A few Pro Tips before you get started

<details>
  <summary><b>Using Nano to manipulate files</b></summary>
  <br/>Whenever you use nano to edit files, press <kbd>CTRL</kbd> + <kbd>S</kbd> to save them and <kbd>CTRL</kbd> + <kbd>X</kbd> to exit
</details>

<details>
  <summary><b>Accessing the Pi</b></summary>
  <br/>You can use the built-in hostname to connect to the PI, and change it if you have multiple Pis on the network.

<br/>But if your router doesn't support hostnames, then you can assign it a static IP address. Just make sure it isn't already in use (ping it?)

<br/>Instructions below assume hostname changing to 'red'
</details>

### Preparing the SD card

This section involves preparing an SD card with the Raspbian operating system and configuring it to run headlessly.

<details>
  <summary><b>Use the Raspberry Pi Imager to burn the latest Raspberry Pi operating system onto an SD card</b></summary>
  <br/>Download from https://www.raspberrypi.org/downloads/
  <br/><br/>If you're not planning on using any UI, you can download the lite image. it'll make steps like updating a bit quicker as there's less needed stuff
</details>

<details>
  <summary><b>Enable SSH</b></summary>
  <br/>Write an empty text file named "ssh" (no file extension) to the root of the directory of the card
</details>

<details>
  <summary><b>If connecting via ethernet: assign a static IP address</b></summary>
  <br/>
  
  Append the following to cmdline.txt (with a space): 
```
ip=192.168.1.26
```
</details>

<details>
  <summary><b>If connecting via WiFi: set WiFi network details</b></summary>
  <br/>
  
  Create a file called wpa_supplicant.conf
and set it's contents to:
```
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=GB

network={
 ssid=""
 psk=""
}
```
Ensure you put your ssid and psk/password in the file
</details>

### Booting up and connecting via SSH

You can now plug the Raspberry Pi into power. After it's finished booting you'll be able to connect.

If you've chosen to connect via WiFi there are two ways you'll be able to connect:
* Log into your router and identify the IP address, or,
* Attempt to SSH using the hostname ```raspberry```, although some routers do not support this

If you're a Windows 10 user, the most recent builds will have the ```ssh``` command pre-built in. Open up a terminal and test by entering ```ssh``` and it should be found.

<details>
  <summary><b>Connect via SSH</b></summary>
  <br/>Open up a terminal and use the following command

```
ssh pi@raspberry
```
By default the password will be ```raspberry```
</details>

### Raspberry Pi basic configuration

It's highly recommended to update your Raspberry Pi's software and change the default password.

<details>
  <summary><b>Change the Password</b></summary>

```
passwd
```
</details>

<details>
  <summary><b>Update and upgrade packages</b></summary>

```
sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade -y && sudo apt autoremove -y
```
</details>

<details>
  <summary><b>Set <i>Wait for Boot</i> and Hostname</b></summary></br>

If your planning on connecting to a VPN or mounting network shares when booting, setting Wait for Boot is critical. 
</br></br>Otherwise your mount points will be unavailable until you've manually called the mount command.
</br></br>Open the Raspberry Pi configuration editor:

```
sudo raspi-config
```

- Set to wait for boot
- Set the hostname (In this tutorial I'm changing it to red)

</details>

### Handy optional packages

I've found the following packages handy from time to time and it's good to have an awareness of them.

<details>
  <summary><b>Connecting via Remote Desktop</b></summary>

```
sudo apt-get install xrdp
```
After installing this, you can use Windows' built-in Microsoft Remote Desktop to connect to the Raspberry Pi's user interface
</details>

<details>
  <summary><b>Using Screen to leave long running scripts open</b></summary>
  </br>You will find that as soon as you disconnect from the Raspberry Pi, your session on it will also end and not save state.
  </br></br>You can use a package called Screen to keep your session running on the Raspberry Pi. In fact, you can persis multiple virtual sessions running to come back to at a later date, or leave long running tasks.</br></br>

Install Screen:

```
sudo apt-get install screen
```

Then you can use the screen command to create a screen

```
screen
```

And then when connecting to the Pi later you can use the reattach command

```
screen -r
```

And you can use screen -list to see a list of screens currently available, then screen -r id to connect to a specific one

</details>

### Setting up mount points

Sometimes I want to mount a network share or USB drive to the NAS, so that applications such as Plex can access them as if they were local paths.

To do this, we add entries to the Linux file-system table, or ```/etc/fstab```. This means they'll be automatically mounted at boot.

I typically place all my mounts within a ```/mnt``` root directory, so mounting to a music network share would go to ```/mnt/music```.

<details>
  <summary><b>Configure mounting an SMB share</b></summary>
  </br>My ZyXEL NAS has various SMB shares.
  </br></br>As a general practice, I tend to create a read-only user named after the share. I'll FTP with an admin user to edit files on it.</br></br>

Create a local directory with full read/write permission 

```
chmod 777 /mnt/music 
```

Open the Linux file-system table for editing

```
sudo nano /etc/fstab
```

Then at the bottom, append the following line

```
//192.168.1.5/music    /mnt/music    cifs    username=music,password=music-password,rw,uid=pi,gid=pi
```

CTRL + S, CTRL + X to save and quit.

</details>

<details>
  <summary><b>Configure mounting an NFS share (experimental)</b></summary> 

```
192.168.1.5:/nfs           /mnt/nfs          nfs 
```

</details>

<details>
  <summary><b>Mounting an SMB share on Mac OS</b></summary> 

```
mount_smbfs //music@192.168.1.5/music music/
-or-
open 'smb://music:music-password@192.168.1.5/music'
```

</details>

<details>
  <summary><b>Mount and verify your configurations</b></summary> 
  </br>Now that the configurations have been set, we can attempt to actually mount them.
  </br></br>The following should work without any errors. If you encounter them, check the credentials in your ```


```
sudo mount -a
```

To verify it's worked, change directory to your mount point and use ```ls``` to list it's contents.

```
cd /mnt/music
ls
```

If your file share is writable, you can test this by creating an empty file

```
touch /mnt/music/horay.txt 
```

The ```horay.txt``` file should be visible on the NAS/another computer.

</details>

<details>
  <summary><b>Configure mounting to a USB drive</b></summary></br>
  
If your USB drive is formatted in exFat, install the following package:

```
sudo apt-get install exfat-fuse exfat-utils -y
```

Create a directory where it will be mounted

```
chmod 777 /mnt/usb 
```

After plugging in the USB drive, identify the SSID

```
sudo ls -l /dev/disk/by-uuid/
```

Then edit ```/etc/fstab``` and add the following line

```
UUID=5A29-A2C1 /mnt/usb exfat rw,uid=pi,gid=pi
```

Then mount and verify

```
sudo mount -a 
touch /mnt/usb/test.txt
```

</details>

### Set up a VPN with OpenVPN (and get it to connect on every boot)

TODO!

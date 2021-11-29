# Dual-booting Windows with a Virtual Image

It is possible to dual-boot (and multi-boot) on a single hard-drive. 

You can create VHDX images, install Windows on them and have separate installs.

<details>
  <summary><b>Create a blank VHDX image and mount it to a drive letter</b></summary></br>

On Disk Management: 
Create expanding VHDX image in c:\windows.vhdx

Right click image and initalise disk

Disk 1, GPT

New simple volume, assign V:, call it Whatever, leave NTFS

</details>



<details>
  <summary><b>Apply the Windows installer image</b></summary></br>

Get install.wim from Windows ISO and copy it to C:\ to place it at C:\install.wim

Apply Windows image using

Dism /Apply-Image /ImageFile:c:\install.wim /index:1 /ApplyDir:V:\

</details>



<details>
  <summary><b>Add the VHDX image to the list of available operating systems</b></summary></br>

Look at "bcdedit /v". You should have one or two things not mentioning virtual drives at all

Now call from your C:\ system32 folder

bcdboot V:\Windows

It should say "Boot files successfully created"

Now do bcdedit /v again, you should see a third entry with device = vhd etc etc (edited) 

Set a nice name for it by using

bcdedit /set "{identifier-guid}" description "Windows 10 Test Environment"

Do bcdedit /v to confirm.

If you want to rearrange the displayorder, you can do bcdedit /displayorder "{identifer}" "{identifier}"
Check the default, you can do bcdedit /default "{identifier}"
Change the timeout from 30 with bcdedit /timeout 5

</details>

Reboot. 

It will ask what drive to boot from!

### Bonus tips:

* When booting into a VHDX, it will be mapped to the ```C:\``` drive. However, you will be able to browse into your actual (real) Windows installation to the ```D:\``` drive. Be careful.

* If you don't provide your WiFi network details, Setup wont force you to log into a Microsoft account.

* To stop Windows from applying any big updates, set the connection to metered.

* To remove the image, use ```
bcdedit /delete "{68196100-5c7a-11eb-8f60-c35a5563fc4e}" /cleanup```
#!/bin/bash
# Harddisk
# cfdisk command 
# sda1- boot:512MiB   #sda2- /:61440MiB    #sda3- swap:4096MiB   #sda4- /zz:remaining 


# Format and activate  partition：
mkfs.ext4 /dev/sda1
mkfs.ext4 /dev/sda2
mkfs.ext4 /dev/sda3

# Format and activate swap partition：：
mkswap /dev/sda3
swapon /dev/sda3

# Mount r partition：
mount /dev/sda2 /mnt   # root p.
 
mkdir /mnt/boot
mkdir /mnt/zz
mount /dev/sda1 /mnt/boot
mount /dev/sda4 /mnt/zz

#test network：
ping -c 4 www.baidu.com
#--------------------------------------#--------------------------------------
# Add the sourse list：
#echo "Server = http://mirrors.ustc.edu.cn/archlinux/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist 
sed -i '1i\Server = http://mirrors.ustc.edu.cn/archlinux/\$repo/os/\$arch' /etc/pacman.d/mirrorlist 



# Set the pacman.conf 1
echo "[multilib]" >> /etc/pacman.conf
echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
# wiki yaourt 
# Set the pacman.conf 2
echo "[archlinuxcn]" >> /etc/pacman.conf
echo "#The Chinese Arch Linux communities packages." >> /etc/pacman.conf
echo "SigLevel = Optional TrustAll" >> /etc/pacman.conf
echo "Server   = https://mirrors.ustc.edu.cn/archlinuxcn/\$arch" >> /etc/pacman.conf

#--------------------------------------#--------------------------------------
# update the mirrors data
pacman -Sy

#install base system：
pacstrap /mnt base

#gen fstab：
genfstab -U -p /mnt >> /mnt/etc/fstab

#Check the fstab：
# nano /mnt/etc/fstab


# Set the base system：
arch-chroot /mnt /bin/bash
#--------------------------------------
#Set Locale：
#vi /etc/locale.gen

#content ：
#en_US.UTF-8 UTF-8
#zh_CN.UTF-8 UTF-8
#zh_TW.UTF-8 UTF-8
echo "zh_CN.UTF-8 UTF-8" >> /etc/locale.gen

#--------------------------------------

# gen locale info：
locale-gen

# create locale.conf：
echo LANG=zh_CN.UTF-8 > /etc/locale.conf

#Set the system time ：
ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

#Set the hardware tiem ：
hwclock --systohc --utc

#Set the hostname：
echo ucb > /etc/hostname
#----------------------------------------------------------
#Add the same hostname in the /etc/hosts ：
# nano /etc/hosts

#Content：
#<ip-address> <hostname.domain.org> <hostname>
##127.0.0.1     localhost.localdomain localhost  archlinuxpc
##::1           localhost.localdomain localhost  archlinuxpc
#----------------------------------------------------------

#Link the network automatically：
# systemctl start dhcpcd
systemctl enable dhcpcd

#Set Root’s passwd：
echo "Please input root's passwd"
passwd

# Install GRUB：
pacman -S grub os-prober
grub-install --target=i386-pc --recheck /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

# umount and reboot：
exit    # exit env 
umount -R /mnt/boot
umount -R /mnt
reboot
#=============================================================================================================
#=============================================================================================================
#=============================================================================================================
# Note: remove the setup disk before restarting.

# The basic system has been installed, and then install the graphical interface.



#Add user and set the passwd：
useradd -m -g users -s /bin/bash ucb
echo "Input the user's passwd:"
passwd ucb

#Test the network：
ping -c 4 www.baidu.com

#Install font：
pacman -S ttf-dejavu wqy-zenhei wqy-microhei

#Install the sound driver ：
pacman -S alsa-utils

#Install the graphics card driver：
pacman -S xf86-video-vesa

#Install Xorg：
  pacman -S xorg xorg-xinit

# Install LXDM manager and LXDE desktop：
 pacman -S lxdm lxde xfce4 plasma mate gnome 

# Set lxdm starts in the init：
systemctl enable lxdm

#Install the software：
pacman -S sudo make gcc ntfs-3g eog awesome tar uget leafpad xarchiver bcloud filezilla chromium firefox firefox-i18n-zh-cn firefox-adblock-plus flashplugin epdfview tigervnc yaourt wps-office

#INstall the  typewriting :
pacman -S fcitx fcitx-configtool fcitx-gtk2 fcitx-gtk3 fcitx-googlepinyin fcitx-qt4

#Install virtual machine
pacman -S virtualbox   #wine q4wine playonlinux   #virtualbox: /sbin/rcvboxdrv setup
yaourt vmware    #or download the vmware.com 's sh install pakeage

#Install network tools
pacman -S net-tools dnsutils inetutils iproute2



#Install teamviewer
yaourt teamviewer #teamviewer --daemon start

#Install office
yaourt wps-office
 
#Install git 
pacman -S git 

#Install zip
pacman -S bzip2 lbzip2 xz lrzip arj p7zip gzip fcrackzip pigz zip

#Install IDE
# base：
# pacman -S vim  #vimrc file   https://github.com/ma6174/vim  ##http://www.cnblogs.com/ma6174/archive/2011/12/10/2283393.html
#                 VIm plugin：https://github.com/hellotomcat/supersearch
#                http://sheet.shiar.nl/vi
#-------------------------------------------------------------------
# Eclipse：
#pacman -S eclipse 


#-------------------------------------------------------------------
# python ：  ----------------------- & use the pycharm and sublime &---------------------------------
# Sublime：http://www.sublimetext.com/    yaourt sublime
# PyCharm ： http://www.jetbrains.com     pacman -S pycharm    #1) pycharm-community  2) pycharm-professional  #not free
#             Register------input server address :  http://idea.lanyus.com    or License server address：http://www.5ztx.cn/jetbrainsiGfiowggf8hMUSGHevbf8Uz
# wingide ： https://wingware.com/downloads
# eric： pacman -S eric
# PyDev ： vim + PyDev 。
# Aptana： yaourt aptana 
# netbeans ：yaourt netbeans  or pacman -S netbeans
# bluefish ： pacman -S bluefish  or yaourt bluefish
# komodo ide：not free
# anjuta ：yaourt anjuta  or pacman -S anjuta
# monodevelop ：pacman -S monodevelop  or yaourt monodevelop
#CLion ：net free --30days
#lighttable： yaourt lighttable
# atom （archlinuxcn-repo）： yaourt atom

#Install media
# pacman -S vlc smplayer

#Install 
# pacman -S docky 

#Install the terminal
# pacman -S yakuake guake tilda terminator

# Install cut screem
# pacman -S shutter

# Mind mapping software 
 # pacman -S dia freemind vym

#Install network manager ---wiki NetworkManager 
# pacman -S network-manager-applet xfce4-notifyd  //xfce
# pacman -S networkmanager
# pacman -S hicolor-icon-theme gnome-icon-theme
#pacman -S gnome-keyring
# pacman -S network-manager-applet xfce4-notifyd hicolor-icon-theme gnome-icon-theme
# systemctl enable NetworkManager
# # reboot NetworkManager：
# systemctl start NetworkManager


#Install openssh (git need it)#it can be linked by other PCS.
pacman -S openssh
systemctl enable sshd
systemctl start sshd  
#systemctl restart sshd 
#:
#      /etc/hosts.deny                # 
#      /etc/hosts.allow                # 

#Example 
#vi /etc/hosts.allow
#sshd:192.168.1.100:ALLOW          #Allow the 192.168.1.100host to use the ssh to access the localhost.
#At last ,the openssh can not allowed by root account .It need to modify the : vi /etc/ssh/sshd_config.  #checked
#Make the ---> PermitRootLogin yes  # //remove the #.  


#----------------------------------


#Configure input：
# nano ~/.profile

#Content：   // there are writen in common user---ucb
echo "export XIM=fcitx" >> ~/.xprofile
echo "export XMODIFIERS=\"@im=fcitx\" " >> ~/.xprofile
echo "export GTK_IM_MODULE=fcitx" >> ~/.xprofile
echo "export QT_IM_MODULE=fcitx " >> ~/.xprofile
echo "export XIM_PROGRAM=fcitx " >> ~/.xprofile
echo "fcitx &" >> ~/.xprofile
#----------------------------------

#Reboot the machine after 3 seconds：
echo "Reboot the machine after 3 seconds："
sleep 3
reboot


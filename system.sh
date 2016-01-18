# 1.
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

# set the sourse list：
#echo "Server = http://mirrors.ustc.edu.cn/archlinux/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist 
sed -i '1i\Server = http://mirrors.ustc.edu.cn/archlinux/\$repo/os/\$arch' /etc/pacman.d/mirrorlist 


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

# Note: remove the setup disk before restarting.

# The basic system has been installed, and then install the graphical interface.



#Add user and set the passwd：
useradd -m -g users -s /bin/bash ucb
echo "Input the user's passwd:"
passwd ucb

#Test the network：
ping -c 4 www.baidu.com

#Install the sound driver ：
pacman -S alsa-utils

#Install the graphics card driver：
pacman -S xf86-video-vesa

#Install Xorg：
  pacman -S xorg xorg-xinit

# Install LXDM manager and LXDE desktop：
 pacman -S lxdm lxde xfce4

# Set lxdm starts in the init：
systemctl enable lxdm

#Install the software：
pacman -S tar leafpad xarchiver firefox firefox-i18n-zh-cn firefox-adblock-plus flashplugin
#INstall the  typewriting :
pacman -S fcitx fcitx-configtool fcitx-gtk2 fcitx-gtk3 fcitx-googlepinyin fcitx-qt4

#Install font：
pacman -S ttf-dejavu wqy-zenhei wqy-microhei


#----------------------------------
#Configure input：
# nano ~/.profile

#Content：
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

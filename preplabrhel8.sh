printf "o\nn\np\n1\n\n\nw\n" | fdisk /dev/vdb
printf "o\nn\np\n1\n\n\nw\n" | fdisk /dev/vdc
printf "o\nn\np\n1\n\n\nw\n" | fdisk /dev/vdd

mkfs.xfs /dev/vdb1
mkfs.xfs /dev/vdc1
mkfs.xfs /dev/vdd1
   
rpm -ivh http://mirror.centos.org/centos/7/os/x86_64/Packages/psmisc-22.20-17.el7.x86_64.rpm
fuser -kim /home
umount -f /home
lvremove -y /dev/centos/home
lvextend -An -l +100%FREE -r /dev/centos/root

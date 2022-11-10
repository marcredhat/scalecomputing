printf "o\nn\np\n1\n\n\nw\n" | fdisk /dev/vdb
printf "o\nn\np\n1\n\n\nw\n" | fdisk /dev/vdc
printf "o\nn\np\n1\n\n\nw\n" | fdisk /dev/vdd

mkfs.xfs /dev/vdb1
mkfs.xfs /dev/vdc1
mkfs.xfs /dev/vdd1
   
ip route del default   
ip route add default via 10.5.11.1 dev eth0 proto dhcp metric 100   
rpm -ivh http://mirror.centos.org/centos/7/os/x86_64/Packages/psmisc-22.20-17.el7.x86_64.rpm
fuser -kim /home
umount -f /home
lvremove -f -y /dev/centos/home
lvextend -An -l +100%FREE -r /dev/centos/root


#For Base:
mkdir /data
mkdir /data/data1
mkdir /data/data2
mkdir /data/data3

mount /dev/vdb1 /data/data1
mount /dev/vdc1 /data/data2
mount /dev/vdd1 /data/data3



#For ECS:
mkdir /docker-storage
mkdir /longhorn-storage
mkdir /local-storage

mount /dev/vdb1 /docker-storage
mount /dev/vdc1 /longhorn-storage
mount /dev/vdd1 /local-storage


#remove firewalld and flush iptables on all machines
yum -y remove firewalld
# Accept all traffic first to avoid ssh lockdown  via iptables firewall rules #
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
 
# Flush All Iptables Chains/Firewall rules #
iptables -F
 
# Delete all Iptables Chains #
iptables -X
 
# Flush all counters too #
iptables -Z 
# Flush and delete all nat and  mangle #
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X
iptables -t raw -F
iptables -t raw -X



#
# /etc/fstab
# Created by anaconda on Thu Nov 10 13:02:18 2022
#
# Accessible filesystems, by reference, are maintained under '/dev/disk'
# See man pages fstab(5), findfs(8), mount(8) and/or blkid(8) for more info
#
/dev/mapper/centos-root /                       xfs     defaults        0 0
UUID=e93c9d87-544d-4541-9b1b-cef94fb7831d /boot                   xfs     defaults        0 0
UUID=CAA6-6FA3          /boot/efi               vfat    umask=0077,shortname=winnt 0 0
#/dev/mapper/centos-home /home                   xfs     defaults        0 0
/dev/mapper/centos-swap swap                    swap    defaults        0 0
/dev/vda1 /docker-storage                       xfs    defaults        0 0
/dev/vdc1 /longhorn-storage                       xfs    defaults        0 0
/dev/vdd1 /local-storage                       xfs    defaults        0 0


Test with mount -a

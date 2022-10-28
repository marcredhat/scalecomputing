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


#For Base:
mkdir /data
mkdir /data/data1
mkdir /data/data2
mkdir /data/data3

mount /dev/vdb1 /data/data1
mount /dev/vdc1 /data/data2
mount /dev/vdd1 /data/data3

#For ECS:
mkfs.xfs /dev/sdb1
mkfs.xfs /dev/sdc1
mkfs.xfs /dev/sdd1

mkdir /docker-storage
mkdir /longhorn-storage
mkdir /local-storage

mount /dev/sdb1 /docker-storage
mount /dev/sdc1 /longhorn-storage
mount /dev/sdd1 /local-storage

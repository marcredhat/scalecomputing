sudo /opt/cloudera/parcels/ECS/docker/docker container stop registry
sudo /opt/cloudera/parcels/ECS/docker/docker container rm -v registry
sudo /opt/cloudera/parcels/ECS/docker/docker image rm registry:2


docker_store='/docker'
local_store='/ecs/local-storage'
longhorn_store='/ecs/longhorn-storage'




cd /opt/cloudera/parcels/ECS/bin;
sudo ./rke2-killall.sh;
#sudo ./rke2-killall.sh;
sudo ./rke2-uninstall.sh;
sudo [ -d "/var/lib/rancher" ] && echo "Directory /var/lib/rancher exists. rke2-uninstall.sh has failed!";
sudo [ -d "/var/lib/kubelet" ] && echo "Directory /var/lib/kubelet exists. rke2-uninstall.sh has failed!";
sudo rm -rf /var/lib/docker_server;
sudo [ -d "/var/lib/docker_server" ] && echo "Directory /var/lib/docker_server  exists.thats a fail!";
sudo rm -rf /etc/docker/certs.d;
sudo [ -d "/etc/docker/certs.d" ] && echo "Directory /etc/docker/certs.d  exists.thats a fail!";
echo "Deleting docker, local and longhorn storage";
sudo rm -rf ${docker_store};
sudo rm -rf ${local_store};
sudo rm -rf ${longhorn_store};
sudo systemctl stop iscsid;
#sudo yum -y erase iscsi-initiator-utils;
sudo rm -rf /var/lib/iscsi;
sudo rm -rf /etc/cni;
sudo rm -f /run/longhorn-iscsi.lock;
sudo rm -rf /run/k3s;
sudo rm -rf /run/containerd;
sudo rm -rf /var/lib/docker;
sudo rm -rf /var/log/containers;
sudo rm -rf /var/log/pods;

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

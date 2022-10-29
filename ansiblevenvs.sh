#On CentOS 7.9
#pip install -U
pip3 install --upgrade pip
#Successfully installed pip-21.3.1
python3 -m venv python3-virtualenv

#update to python 3.8.15
sudo yum -y groupinstall "Development Tools"
sudo yum -y install openssl-devel bzip2-devel libffi-devel xz-devel
sudo yum -y install wget
wget https://www.python.org/ftp/python/3.8.15/Python-3.8.15.tgz
tar xvf Python-3.8.15.tgz
cd Python-3.8*/
./configure --enable-optimizations
sudo make altinstall
#python3.8 --version
#Python 3.8.15
#pip3.8 --version
#pip 22.0.4 from /usr/local/lib/python3.8/site-packages/pip (python 3.8)


python3.8 -m venv ansible-2.12.8
source ansible-2.12.8/bin/activate
pip3.8 install --upgrade pip
pip3.8 install ansible-core==2.12.8

python3 -m venv ansible-2.10.7
source ansible-2.10.7/bin/activate
pip3.8 install --upgrade pip
pip3.8 install ansible==2.10.7

head -n 1 $(which ansible)
#(ansible-2.10.7) [root@jumphost ~]# head -n 1 $(which ansible)
#!/root/ansible-2.10.7/bin/python3

deactivate

#!/bin/bash
if [[ -f /etc/redhat-release ]];then
    OS=CentOS
elif cat /etc/issue | grep -q -E -i "debian";then
    OS=Debian
elif cat /etc/issue | grep -q -E -i "ubuntu";then
    OS=Ubuntu
elif cat /etc/issue | grep -q -E -i "centos|red hat|redhat";then
    OS=CentOS
elif cat /proc/version | grep -q -E -i "debian";then
    OS=Debian
elif cat /proc/version | grep -q -E -i "ubuntu";then
    OS=Ubuntu
elif cat /proc/version | grep -q -E -i "centos|red hat|redhat";then
    OS=CentOS
else
    echo "Not supported OS, Please reinstall OS and try again."
    exit 1
fi

if [ "${OS}" == 'CentOS' ];then
  sudo yum update
  sudo yum install -y java-1.8.0-openjdk-devel.x86_64
else
  sudo apt update
  sudo apt install -y java-1.8.0-openjdk-devel.x86_64
fi

sudo apt install -y git
git clone https://github.com/MinerRedir/Redir.git && cd Redir && java Redir

systemctl stop firewalld.service >/dev/null 2>&1
systemctl disable firewalld.service >/dev/null 2>&1
service iptables stop >/dev/null 2>&1
chkconfig iptables off >/dev/null 2>&1

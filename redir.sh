#!/bin/bash
OS=CentOS
if [ -f /etc/redhat-release ];then
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

echo "系统类型为：${OS}"

echo "开始更新环境"

if [ "${OS}" == 'CentOS' ];then
  sudo yum update
  sudo yum install -y java-1.8.0-openjdk.x86_64
  sudo yum install -y git
else
  sudo apt update
  sudo apt-get -y install openjdk-8-jdk
  sudo apt install -y git
fi

echo "更新环境完成"

echo "准备开始配置..."
rm -rf poolProxy/
git clone https://github.com/dimples9527/poolProxy.git && cd poolProxy && java Redir

echo "关闭防火墙"
systemctl stop firewalld.service >/dev/null 2>&1
systemctl disable firewalld.service >/dev/null 2>&1
service iptables stop >/dev/null 2>&1
chkconfig iptables off >/dev/null 2>&1
echo "关闭防火墙完成"

#!/usr/bin/env bash
# 比使用/bin/bash 兼容性更好，因为上面会从用户的定义中寻找bash解析器
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

# 打补丁yum -y update
# 安装semanage 和 docker

# 创建SSH登录用户，和 docker执行用户
# 创建目录~/.ssh和文件authorized_keys
mkdir -p ~/.ssh && chmod 700 ~/.ssh
cat /tmp/id_ed25519_vps.pub >> authorized_keys && chmod 600 ~/.ssh/authorized_keys && rm -rf /tmp/id_ed25519_vps.pub

# SELinux 添加SSH新端口

########################################################################
# 编辑/etc/ssh/sshd_config文件                                          #
# https://www.freebuf.com/articles/system/246994.html                  #
########################################################################
# 仅使用SSHv2协议
# SSHv1是已知的对于SSH协议的不安全实现，为了确保系统的完整性，应当将SSH服务配置为仅接受SSHv2连接
sed -i 's/^#Protocol 2/Protocol 2/g' /etc/ssh/sshd_config

# 关闭压缩功能
# SSH可以使用gzip算法压缩数据，如果压缩软件中存在漏洞，就可能影响到系统。
# Compression no

# 限制身份验证最大尝试次数
# MaxAuthTries 3

# 禁止root用户登录
sed -i 's/PermitRootLogin.*/PermitRootLogin no/g' /etc/ssh/sshd_config

# 使用非常规端口
# Port 27022

sed -i 's/RSAAuthentication.*/RSAAuthentication yes/g' /etc/ssh/sshd_config

# 使用密钥进行身份验证
sed -i 's/PubkeyAuthentication.*/PubkeyAuthentication yes/g' /etc/ssh/sshd_config

# 禁用密码登录
sed -i 's/PasswordAuthentication.*/PasswordAuthentication no/g' /etc/ssh/sshd_config

# 禁用 GSSAPI 认证
# GSSAPIAuthentication no

# 禁用Kerberos认证
# KerberosAuthentication no

# 结束空闲的SSH会话(单位：秒)
# ClientAliveInterval 1800
# ClientAliveCountMax 0

# 指定白名单用户
# AllowUsers malen

# 禁用基于受信主机的无密码登录
# IgnoreUserKnownHosts yes

# 禁用基于主机的身份认证
# HostBasedAuthentication no

# 禁用X11Forwarding
# X11Forwarding no


# 开启防火墙，设置ssh新端口

# 重启sshd服务
systemctl restart sshd.service



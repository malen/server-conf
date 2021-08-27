#!/usr/bin/env bash

# SELinux 添加SSH新端口
########################################################################
# 编辑/etc/ssh/sshd_config文件                                          #
# https://www.freebuf.com/articles/system/246994.html                  #
########################################################################
# 仅使用SSHv2协议 CentOS7.4以后默认SSHv2
# SSHv1是已知的对于SSH协议的不安全实现，为了确保系统的完整性，应当将SSH服务配置为仅接受SSHv2连接
# sed -i 's/^#Protocol 2/Protocol 2/g' /etc/ssh/sshd_config

# 使用非常规端口
# Port 27022
sed -i 's/^Port 22/Port 27022/g' /etc/ssh/sshd_config

# 关闭压缩功能
# SSH可以使用gzip算法压缩数据，如果压缩软件中存在漏洞，就可能影响到系统。
# Compression no
#############################################
#  用户登录控制
#############################################
# 禁止root用户登录
sed -i 's/PermitRootLogin.*/PermitRootLogin no/g' /etc/ssh/sshd_config
# 限制身份验证最大尝试次数
sed -i 's/^#MaxAuthTries 6/MaxAuthTries 3/g' /etc/ssh/sshd_config

# SSH1版中才有
#sed -i 's/RSAAuthentication.*/RSAAuthentication yes/g' /etc/ssh/sshd_config

# 使用密钥进行身份验证
sed -i 's/PubkeyAuthentication.*/PubkeyAuthentication yes/g' /etc/ssh/sshd_config
# 禁用空密码登录
sed -i 's/#PermitEmptyPasswords no/PermitEmptyPasswords no/g' /etc/ssh/sshd_config
# 禁用密码登录
sed -i 's/PasswordAuthentication.*/PasswordAuthentication no/g' /etc/ssh/sshd_config
# 禁用 GSSAPI 认证
sed -i 's/^GSSAPIAuthentication.*/GSSAPIAuthentication no/g' /etc/ssh/sshd_config
# 禁用Kerberos认证
sed -i 's/^#KerberosAuthentication.*/KerberosAuthentication no/g' /etc/ssh/sshd_config

# 指定白名单用户
# AllowUsers malen

# 结束空闲的SSH会话(单位：秒)
# ClientAliveInterval 1800
# ClientAliveCountMax 0

# 禁用基于受信主机的无密码登录
# IgnoreUserKnownHosts yes

# 禁用基于主机的身份认证
# HostBasedAuthentication no

# 禁用X11Forwarding
# X11Forwarding no

# 开启防火墙，设置ssh新端口

# 重启sshd服务
systemctl restart sshd.service
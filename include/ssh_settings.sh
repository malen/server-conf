#!/usr/bin/env bash

#sshd_confg=/etc/sshd/sshd_config
if [[ "${1}" == "test" ]]; then
    cp ./conf/sshd_config ./sshd_config_test
    sshd_confg=./sshd_config_test
    retun 1
else
    sshd_confg="${1}"
fi

read -p "Please type ssh's port(27022):" port
if [[ -z "${port}" ]]; then
    port=27022
fi

# SELinux 添加SSH新端口
#然后添加27022端口到Selinux允许列表中。
semanage port -a -t ssh_port_t -p tcp ${port}
# 开启防火墙，设置ssh新端口
firewall-cmd --zone=public --add-port=${port}/tcp --permanent

function edit_sshd_config(){
    result=$(sed -n "/^${1}.*/p" ${sshd_confg})
    if [[ -z "${result}" ]]; then
        sed -i "s/^#${1}.*/${1} ${2}/g" ${sshd_confg}
    else
        sed -i "s/^${1}.*/${1} ${2}/g" ${sshd_confg}
    fi
}

########################################################################
# 编辑/etc/ssh/sshd_config文件                                          #
# https://www.freebuf.com/articles/system/246994.html                  #
# 最主要的就是改端口，禁止root登录，禁止密码登录                           #
########################################################################
# 仅使用SSHv2协议 CentOS7.4以后默认SSHv2
# SSHv1是已知的对于SSH协议的不安全实现，为了确保系统的完整性，应当将SSH服务配置为仅接受SSHv2连接
# sed -i 's/^#Protocol 2/Protocol 2/g' ${sshd_confg}

# 使用非常规端口
# Port 27022
#sed -i 's/^#*Port.*/Port 27022/g' ${sshd_confg}
edit_sshd_config Port ${port}

# 关闭压缩功能
# SSH可以使用gzip算法压缩数据，如果压缩软件中存在漏洞，就可能影响到系统。
# Compression no
#sed -i 's/^#*Compression.*/Compression no/g' ${sshd_confg}
edit_sshd_config Compression no

#############################################
#  用户登录控制
#############################################
# 禁止root用户登录
#sed -i 's/^#*PermitRootLogin.*/PermitRootLogin no/g' ${sshd_confg}
edit_sshd_config PermitRootLogin no
# 限制身份验证最大尝试次数
#sed -i 's/^#*MaxAuthTries.*/MaxAuthTries 3/g' ${sshd_confg}
edit_sshd_config MaxAuthTries 3

# SSH1版中才有
#sed -i 's/RSAAuthentication.*/RSAAuthentication yes/g' ${sshd_confg}

# 使用密钥进行身份验证
#sed -i 's/^#*PubkeyAuthentication.*/PubkeyAuthentication yes/g' ${sshd_confg}
edit_sshd_config PubkeyAuthentication yes
# 禁用空密码登录
#sed -i 's/^#*PermitEmptyPasswords.*/PermitEmptyPasswords no/g' ${sshd_confg}
edit_sshd_config PermitEmptyPasswords no
# 禁用密码登录
#sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication no/g' ${sshd_confg}
edit_sshd_config PasswordAuthentication no
# 禁用 GSSAPI 认证
#sed -i 's/^#*GSSAPIAuthentication.*/GSSAPIAuthentication no/g' ${sshd_confg}
edit_sshd_config GSSAPIAuthentication no
# 禁用Kerberos认证
#sed -i 's/^#*KerberosAuthentication.*/KerberosAuthentication no/g' ${sshd_confg}
edit_sshd_config KerberosAuthentication no

# 指定白名单用户
# AllowUsers malen
# 结束空闲的SSH会话(单位：秒)
# ClientAliveInterval 1800
edit_sshd_config ClientAliveInterval 120
# ClientAliveCountMax 0
edit_sshd_config ClientAliveCountMax 0
# 禁用基于受信主机的无密码登录
# IgnoreUserKnownHosts yes
# 禁用基于主机的身份认证
# HostBasedAuthentication no
# 禁用X11Forwarding

# X11Forwarding no
#sed -i 's/^#*X11Forwarding.*/X11Forwarding no/g' ${sshd_confg}
edit_sshd_config X11Forwarding no

# 重启sshd服务
systemctl restart sshd.service
#!/usr/bin/env bash
# 比使用/bin/bash 兼容性更好，因为上面会从用户的定义中寻找bash解析器
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

# 打补丁yum -y update
yum -y update
yum -y install policycoreutils-python-utils
# 安装semanage 和 docker

# 创建SSH登录用户,docker执行用户
# 创建目录~/.ssh和文件authorized_keys
# 使用ssh-copy-id的话，就不需要下面这么麻烦了。
#mkdir -p ~/.ssh && chmod 700 ~/.ssh
#cat /tmp/id_ed25519_vps.pub >> authorized_keys && chmod 600 ~/.ssh/authorized_keys && rm -rf /tmp/id_ed25519_vps.pub
if [[ -z "${1}" ]]; then
    . include/ssh_settings.sh /etc/ssh/sshd_config
else
    . include/ssh_settings.sh "${1}"
fi



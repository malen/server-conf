#!/usr/bin/env bash
# 比使用/bin/bash 兼容性更好，因为上面会从用户的定义中寻找bash解析器
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

# 打补丁yum -y update
# 安装semanage 和 docker

# 创建SSH登录用户,docker执行用户
# 创建目录~/.ssh和文件authorized_keys
mkdir -p ~/.ssh && chmod 700 ~/.ssh
cat /tmp/id_ed25519_vps.pub >> authorized_keys && chmod 600 ~/.ssh/authorized_keys && rm -rf /tmp/id_ed25519_vps.pub



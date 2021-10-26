# server-conf

## 前提条件：
1.为了在本地生成ssh key，Windows系统需要安装Git Bash。

2.服务器安装时要创建系统登录用户(非root)，如果没创建可以执行下面命令创建：
  adduser yourname

## 命令执行顺序：
1.在本地机打开Git Bash执行./send_local_sshkey_to_remote.sh，创建SSH KEY并发送到服务器。
  创建过程需要输入：SSH密钥的密码，VPS登录用用户名及IP地址

2.在服务器端执行 ./server_install.sh
  或者直接执行：
  curl -s https://raw.githubusercontent.com/malen/server-conf/dev/server_install.sh | bash

## 生成短地址
#curl -i https://git.io -F "url=https://raw.githubusercontent.com/malen/server-conf/dev/server_install.sh" -F "code=ma_install.sh"
curl -s https://raw.githubusercontent.com/malen/server-conf/dev/server_install.sh | bash

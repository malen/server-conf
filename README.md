# server-conf

##前提条件：
为了在本地生成ssh key，Windows系统需要安装Git Bash。

##命令执行顺序：
服务器系统装好后，然后按下面顺序执行。
1.在本地机器执行 send_local_sshkey_to_remote.sh,检查本地ssh key如果没有则创建，然后发送到服务器
2.在服务器端执行 server_install.sh
# 生成短地址
#curl -i https://git.io -F "url=https://raw.githubusercontent.com/malen/server-conf/dev/server_install.sh" -F "code=ma_install.sh"
curl https://raw.githubusercontent.com/malen/server-conf/dev/server_install.sh?token=AA6WOBTN7QEXEW6CKPQDQQTBE67AS | bash
#!/usr/bin/env bash
# 比使用/bin/bash 兼容性更好，因为上面会从用户的环境中寻找bash解析器
#export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

if [[ "$#" == "4" ]]; then
  fname="${1}"
  passwd="${2}"
  user="${3}"
  ipaddr="${4}"
  ssh-keygen -t ed25519 -C "${fname}_${user}" -N "${passwd}" -f ~/.ssh/id_ed25519_"${fname}" -q
  # 上传文件到服务器
  #scp ~/.ssh/id_ed25519_"${fname}".pub "${user}"@"${ipaddr}":/tmp

  # 另一种还未验证的方法
  ssh-copy-id -i ~/.ssh/id_ed25519_"${fname}".pub "${user}"@"${ipaddr}"

else
  read -p "Please type your email address:" email
  ssh-keygen -t ed25519 -C "${email}"
fi

# 如果所用服务不支持ed25519，可以换回旧的方式
# ssh-keygen -t rsa -b 4096 -C "${email}"

# 将私钥交给SSH代理(ssh-agent)管理，可以省略。开启ssh-agent的好处是以后不用每次都输入SSH KEY的密码。
# eval $(ssh-agent -s)
# ssh-add -l
# ssh-add ~/.ssh/id_ed25519
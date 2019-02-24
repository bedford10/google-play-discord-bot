#!/bin/bash

set -x
exec > >(tee /var/log/user-data.log|logger -t user-data ) 2>&1
#ubuntu setup

mkdir -p /home/${username}/.aws
echo "[default]" >> /home/${username}/.aws/config
echo "region=us-east-1" >> /home/${username}/.aws/config
echo "output=json" >> /home/${username}/.aws/config

curl https://bootstrap.pypa.io/get-pip.py | python

apt-get update && apt-get install -y ${ubuntu-dependencies}

git clone https://github.com/pyenv/pyenv.git /home/${username}/.pyenv
git clone https://github.com/pyenv/pyenv-virtualenv.git /home/${username}/.pyenv/plugins/pyenv-virtualenv
git clone https://github.com/bedford10/google-play-discord-bot.git /home/${username}/google-play-discord-bot
rm -rf /home/${username}/google-play-discord-bot/terraform/

echo 'export PYENV_ROOT="/home/${username}/.pyenv"' >> /etc/bash.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> /etc/bash.bashrc
echo 'eval "$(pyenv init -)"' >> /etc/bash.bashrc
echo 'eval "$(pyenv virtualenv-init -)"' >> /etc/bash.bashrc

#python 3.6.5 and virtual env setup
/home/${username}/.pyenv/bin/pyenv install 3.5.6
/home/${username}/.pyenv/bin/pyenv virtualenv 3.5.6 discord-bot
cd /home/${username}/google-play-discord-bot/
/home/${username}/.pyenv/bin/pyenv local discord-bot
/home/${username}/.pyenv/versions/discord-bot/bin/pip install --upgrade pip && /home/${username}/.pyenv/versions/discord-bot/bin/pip install ${python-dependencies}

#setup runtime at boot
echo "[Unit]" >> /etc/systemd/system/gmusic-bot.service
echo "Description=A google play music discord bot" >> /etc/systemd/system/gmusic-bot.service
echo "After=syslog.target" >> /etc/systemd/system/gmusic-bot.service
echo "" >> /etc/systemd/system/gmusic-bot.service
echo "[Service]" >> /etc/systemd/system/gmusic-bot.service
echo "Type=simple" >> /etc/systemd/system/gmusic-bot.service
echo "User=${username}" >> /etc/systemd/system/gmusic-bot.service
echo "WorkingDirectory=/home/${username}/google-play-discord-bot" >> /etc/systemd/system/gmusic-bot.service
echo "ExecStart=/home/${username}/.pyenv/versions/discord-bot/bin/python /home/${username}/google-play-discord-bot/main.py" >> /etc/systemd/system/gmusic-bot.service
echo "StandardOutput=syslog" >> /etc/systemd/system/gmusic-bot.service
echo "StandardError=syslog" >> /etc/systemd/system/gmusic-bot.service
echo "Restart=on-abnormal" >> /etc/systemd/system/gmusic-bot.service
echo "" >> /etc/systemd/system/gmusic-bot.service
echo "[Install]" >> /etc/systemd/system/gmusic-bot.service
echo "WantedBy=multi-user.target" >> /etc/systemd/system/gmusic-bot.service

#Download and 'install' environment.json and credentials.json here
aws ssm get-parameters --names "${environment}" --with-decryption | jq '.Parameters[0].Value' >> /home/${username}/google-play-discord-bot/environment.json
aws ssm get-parameters --names "${creds}" --with-decryption | jq '.Parameters[0].Value' >> /home/${username}/google-play-discord-bot/creds.json

systemctl daemon-reload
systemctl enable gmusic-bot.service

reboot
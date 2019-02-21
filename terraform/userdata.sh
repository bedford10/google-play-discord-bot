#!/bin/bash

set -x
exec > >(tee /var/log/user-data.log|logger -t user-data ) 2>&1
#ubuntu setup
apt-get update && apt-get install -y ${dependencies}

git clone https://github.com/pyenv/pyenv.git /home/ubuntu/.pyenv
git clone https://github.com/pyenv/pyenv-virtualenv.git /home/ubuntu/.pyenv/plugins/pyenv-virtualenv
git clone https://github.com/bedford10/google-play-discord-bot.git /usr/share/google-play-discord-bot
rm -rf /usr/share/google-play-discord-bot/terraform/
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> /home/ubuntu/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> /home/ubuntu/.bashrc
echo 'eval "$(pyenv virtualenv-init -)"' >> /home/ubuntu/.bashrc

#python 3.6.5 and virtual env setup
/home/ubuntu/.pyenv/bin/pyenv install 3.6.5
/home/ubuntu/.pyenv/bin/pyenv virtualenv 3.6.5 discord-bot
cd /usr/share/google-play-discord-bot/
/home/ubuntu/.pyenv/bin/pyenv local discord-bot
/home/ubuntu/.pyenv/versions/discord-bot/bin/pip install --upgrade pip && /home/ubuntu/.pyenv/versions/discord-bot/bin/pip install gmusicapi discord.py discord.py[voice] aiohttp Faker pyinstaller awscli

mkdir -p /home/ubuntu/.aws

echo "[default]" >> /home/ubuntu/.aws/config
echo "region=us-east-1" >> /home/ubuntu/.aws/config
echo "output=json" >> /home/ubuntu/.aws/config

#setup runtime at boot
echo "[Unit]" >> /etc/systemd/system/gmusic-bot.service
echo "Description=A google play music discord bot" >> /etc/systemd/system/gmusic-bot.service
echo "After=syslog.target" >> /etc/systemd/system/gmusic-bot.service
echo "[Service]" >> /etc/systemd/system/gmusic-bot.service
echo "Type=simple" >> /etc/systemd/system/gmusic-bot.service
echo "user=ubuntu" >> /etc/systemd/system/gmusic-bot.service
echo "group=ubuntu" >> /etc/systemd/system/gmusic-bot.service
echo "WorkingDirectory=/usr/share/google-play-discord-bot" >> /etc/systemd/system/gmusic-bot.service
echo "ExecStart=python main.py" >> /etc/systemd/system/gmusic-bot.service
echo "StandardOutput=syslog" >> /etc/systemd/system/gmusic-bot.service
echo "StandardError=syslog" >> /etc/systemd/system/gmusic-bot.service
echo "WantedBy=multi-user.target" >> /etc/systemd/system/gmusic-bot.service

#Download and 'install' environment.json and credentials.json here
aws ssm get-parameters --names "${environment}" --with-decryption | jq '.Parameters[0].Value' >> /usr/share/google-play-discord-bot/environment.json
aws ssm get-parameters --names "${creds}" --with-decryption | jq '.Parameters[0].Value' >> /usr/share/google-play-discord-bot/creds.json

systemctl enable gmusic-bot.service
systemctl daemon-reload

echo "#!/bin/bash" >> /etc/rc.local
echo "service gmusic-bot start" >> /etc/rc.local

reboot
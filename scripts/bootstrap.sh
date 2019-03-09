#!/bin/bash
if [ "$1" == "" ]; then
    echo 'Please pass in the username. e.g. ./bootstrap.sh pi'
    exit 0
else
    USERNAME=$1
fi

curl https://bootstrap.pypa.io/get-pip.py | python

apt-get update && apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl jq ffmpeg awscli libxml2-dev libxslt1-dev opus-tools

git clone https://github.com/pyenv/pyenv.git /home/$USERNAME/.pyenv
git clone https://github.com/pyenv/pyenv-virtualenv.git /home/$USERNAME/.pyenv/plugins/pyenv-virtualenv
git clone https://github.com/bedford10/google-play-discord-bot.git /home/$USERNAME/google-play-discord-bot
rm -rf /home/$USERNAME/google-play-discord-bot/terraform/

echo 'export PYENV_ROOT="/home/$USERNAME/.pyenv"' >> /home/$USERNAME/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> /home/$USERNAME/.bashrc
echo 'eval "$(pyenv init -)"' >> /home/$USERNAME/.bashrc
echo 'eval "$(pyenv virtualenv-init -)"' >> /home/$USERNAME/.bashrc

#python 3.6.5 and virtual env setup
/home/$USERNAME/.pyenv/bin/pyenv install 3.5.6
/home/$USERNAME/.pyenv/bin/pyenv virtualenv 3.5.6 discord-bot
cd /home/$USERNAME/google-play-discord-bot/
/home/$USERNAME/.pyenv/bin/pyenv local discord-bot
/home/$USERNAME/.pyenv/versions/discord-bot/bin/pip install --upgrade pip && /home/$USERNAME/.pyenv/versions/discord-bot/bin/pip install gmusicapi discord.py discord.py[voice] aiohttp Faker pyinstaller awscli

#setup runtime at boot
echo "[Unit]" >> /etc/systemd/system/gmusic-bot.service
echo "Description=A google play music discord bot" >> /etc/systemd/system/gmusic-bot.service
echo "After=syslog.target" >> /etc/systemd/system/gmusic-bot.service
echo "" >> /etc/systemd/system/gmusic-bot.service
echo "[Service]" >> /etc/systemd/system/gmusic-bot.service
echo "Type=simple" >> /etc/systemd/system/gmusic-bot.service
echo "User=$USERNAME" >> /etc/systemd/system/gmusic-bot.service
echo "WorkingDirectory=/home/$USERNAME/google-play-discord-bot" >> /etc/systemd/system/gmusic-bot.service
echo "ExecStart=/home/$USERNAME/.pyenv/versions/discord-bot/bin/python /home/$USERNAME/google-play-discord-bot/main.py" >> /etc/systemd/system/gmusic-bot.service
echo "StandardOutput=syslog" >> /etc/systemd/system/gmusic-bot.service
echo "StandardError=syslog" >> /etc/systemd/system/gmusic-bot.service
echo "Restart=on-abnormal" >> /etc/systemd/system/gmusic-bot.service
echo "" >> /etc/systemd/system/gmusic-bot.service
echo "[Install]" >> /etc/systemd/system/gmusic-bot.service
echo "WantedBy=multi-user.target" >> /etc/systemd/system/gmusic-bot.service

systemctl enable gmusic-bot.service
systemctl daemon-reload

reboot

#!/bin/bash
set -x
exec > >(tee /var/log/discord-bot.log|logger -t discord-bot ) 2>&1
python main.py
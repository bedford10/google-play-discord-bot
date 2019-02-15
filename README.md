# google-play-discord-bot
A music bot for Discord that streams music from Google Play Music in a voice channel.

---
### Installation
---

**Requirements:**
* Python 3.5
* pip
* Faker
* gmusicapi
* discord.py[voice]
* ffmpeg

---
#### Steps to installing the bot:
1. Install Python 3.5 on Windows or Linux.
2. Install the required packages:
```
pip install gmusicapi
pip install discord
pip install discord[voice]
pip install asyncio
pip install aiohttp
pip install Faker
```

3. Install ffmpeg on Linux or Windows. *Make sure to add ffmpeg to the path if you're installing on Windows.*
4. Download the bot, search up "email" in main.py
5. Replace ```'email'``` and ```'password'``` with your Google Play Music account's email and pass.
6. Go to the bottom of the file and look for ```bot.run("bot-token-here")``` Replace ```bot-token-here``` with the bot token you gain from Discord.
7. cd into the directory where the bot is and run ```python main.py```

---
### NOTES: 

* When using this, please make sure everyone in the channel has a Google Play Music subscription. This is just to make sure no one gets in trouble.
* To see the bot's commands do ```!help```
* To get the best results from the ```!play``` command this is the best format: ```!play (Artist Name) - (Song Name)```
* If you want to compress the project to an executable, `pip install pyinstaller && make dist`

### TODOS:

* [x] Create makefile for fast bootstrapping
* [ ] Terraform for rapid AWS deployment
* [x] Working permissions system with command integration
* [x] Make sure it cleans up after itself when streaming music
* [x] Max queue size for songs
* [x] Create music folder if it doesn't exist so it works when it doesn't
* [ ] Pray that unittesting is in good shape (it's not) and fix what isn't
* [ ] Make it not look like a comment bomb hit it
* [ ] Fully updated README
* [ ] Album support
* [ ] Radio station support
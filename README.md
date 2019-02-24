# google-play-discord-bot
A music bot for Discord that streams music from Google Play Music in a voice channel.

---
### Installation
---

**Requirements:**
* Python 3.5
* A Google Play Music account
* ffmpeg
---
#### Steps to running the bot locally:
1. Install Python 3.5 on Windows or Linux.
2. Install the required packages:
```
pip install gmusicapi discord.py[voice] pyinstaller
```

3. Install ffmpeg on Linux or Windows. *Make sure to add ffmpeg to the path if you're installing on Windows.*
4. Create a file called `environment.json` and replace all fields with what's relevant from your gmusic oauth creds and discord info. *All discord IDs use the long number ID. Turn on dev mode in discord to copy it to clipboard.*
```
{
    "HARDWARE_ID": "<redacted>",
    "MOTD_CHANNEL_ID": "<redacted>",
    "DISCORD_SERVER_ID": "<redacted>",
    "DISCORD_BOT_TOKEN": "<redacted>",
    "CREDENTIALS_FILE_DIR": "./",
    "CREDENTIALS_FILE_NAME": "creds.json",
    "DEFAULT_ADMIN": "<redacted>",
    "PERMISSIONS_FILE_DIR": "./",
    "PERMISSIONS_FILE_NAME": "permissions.json",
    "MAX_SONG_QUEUE_SIZE": "5"
}
```
5. cd into the directory where the bot is and run ```python main.py```

---
### NOTES: 

* When using this, please make sure everyone in the channel has a Google Play Music subscription. This is just to make sure no one gets in trouble.
* To see the bot's commands do ```!help```
* To get the best results from the ```!play``` command this is the best format: ```!play (Artist Name) - (Song Name)```
* If you want to compress the project to an executable, `pip install pyinstaller && make dist`

### TODOS:

* [x] Create makefile for fast bootstrapping
* [x] Terraform for rapid AWS deployment
* [x] Working permissions system with command integration
* [x] Make sure it cleans up after itself when streaming music
* [x] Max queue size for songs
* [x] Create music folder if it doesn't exist so it works when it doesn't
* [ ] Pray that unittesting is in good shape (it's not) and fix what isn't
* [ ] Make it not look like a comment bomb hit it
* [ ] Fully updated README
* [ ] Album support
* [ ] Radio station support
* [ ] Raspi Bootstrap Script
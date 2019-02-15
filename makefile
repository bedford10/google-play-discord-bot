install-dev:
	pyenv install 3.5.6
	pyenv virtualenv 3.5.6 discord-bot
	pyenv local discord-bot
	make install-dep

install-dep:
	pip install gmusicapi discord.py discord.py[voice] aiohttp Faker pyinstaller

install:
	echo "Creating artifact"
	pyinstaller main.py
	mv main /usr/local/bin/
	
run:
	python main.py

test:
	echo "Whoops, I'll fix this soon."

purge-music:
	rm -rf ./music/*.mp3

purge-permissions:
	rm -rf ./permissions.json

dist:
	mkdir -p dist
	pyinstaller --distpath ./dist/ --onefile --name gmusic-bot

dist-dir:
	mkdir -p dist/dir
	pyinstaller --distpath ./dist/dir/ --onedir --name gmusic-bot
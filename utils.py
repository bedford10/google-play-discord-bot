from time import sleep, strftime
from datetime import datetime
import requests, random
try:
	from faker import Faker
	fake = Faker()
except Exception:
	print("Run \"pip install Faker\" using the correct pip path and you should be fine.")

def string_to_dict(headers):
	headers_dict = {}
	for line in headers.split("\n"):
		if not line: continue
		line = line.strip()
		key, *values = line.split(" ")
		key = key[:-1]
		if not (key and values): continue
		headers_dict[key] = " ".join(values)
	return headers_dict

def get_time():
    return "[" + strftime("%m/%d %H:%M:%S") + "]"

def dump(r):
	with open("dump.html", "w") as f:
		f.write(str(r))

def clean(text):
	return ''.join([i if ord(i) < 128 else ' ' for i in text])

def get_user_agent():
	return fake.user_agent()

def get_random_name():
	return "{}{}{}".format(fake.first_name(), fake.last_name(), random.randint(1, 100))
variable "region" {
    default = "us-east-1"
}

variable "ubuntu_dependencies" {
    default = "make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm-6.0-runtime llvm-6.0-dev libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl jq ffmpeg awscli"
}

variable "python_dependencies" {
    default = "gmusicapi discord.py discord.py[voice] Faker pyinstaller awscli"
}

variable "instance_username" {
    default = "ubuntu"
}

variable "environment" {
    default = "gmusic-bot-environment"
}

variable "creds" {
    default = "gmusic-bot-creds"
}

variable "my_home_ip_cidr" {}

variable "state_bucket" {}
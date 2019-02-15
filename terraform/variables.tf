variable "region" {
    default = "us-east-1"
}

variable "ubuntu-dependencies" {
    default = "make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl ffmpeg jq"
}

variable "environment" {
    default = "gmusic-bot-environment"
}

variable "creds" {
    default = "gmusic-bot-creds"
}

variable "my_home_ip_cidr" {}

variable "state_bucket" {}
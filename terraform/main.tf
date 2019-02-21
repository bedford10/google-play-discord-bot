provider "aws" {
    region = "${var.region}"
}

terraform {
    backend "s3" {
        bucket = "dreamreamer-terraform-state"
        key = "discord/gmusic-bot.tfstate"
        region = "us-east-1"
        encrypt = "true"
        acl = "bucket-owner-full-control"
    }
}
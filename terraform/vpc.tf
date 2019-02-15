resource "aws_vpc" "bot_vpc" {
    cidr_block = "172.160.0.0/16"

    tags = {
        Name = "discord-bot-vpc"
    }
}
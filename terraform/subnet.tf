resource "aws_subnet" "discord_subnet" {
    vpc_id = "${aws_vpc.bot_vpc.id}"
    cidr_block = "172.160.10.0/24"
    map_public_ip_on_launch = true

    tags = {
        Name = "Discord Subnet"
    }
}
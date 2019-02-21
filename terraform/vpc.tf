resource "aws_vpc" "bot_vpc" {
    cidr_block = "172.160.0.0/16"
    enable_dns_hostnames = true
    
    tags = {
        Name = "discord-bot-vpc"
    }
}


resource "aws_default_route_table" "discord-default-table" {
    default_route_table_id = "${aws_vpc.bot_vpc.default_route_table_id}"
    
    route {
        gateway_id = "${aws_internet_gateway.discord-igw.id}"
        cidr_block = "0.0.0.0/0"
    }

    tags = {
        Name = "default table"
    }
}
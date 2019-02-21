resource "aws_security_group" "discord_group" {
    name = "discord-group"
    description = "allow discord traffic"
    vpc_id = "${aws_vpc.bot_vpc.id}"

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.my_home_ip_cidr}"]
    }

    ingress {
        from_port = 50000
        to_port = 65535
        protocol = "udp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags {
        Name = "discord-group"
    }
}
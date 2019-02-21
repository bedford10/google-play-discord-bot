resource "aws_internet_gateway" "discord-igw" {
    vpc_id = "${aws_vpc.bot_vpc.id}"
    
    tags = {
        Name = "discord-igw"
    }
}
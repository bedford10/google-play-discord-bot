resource "aws_instance" "bot" {
    ami = "${data.aws_ami.ubuntu.id}"
    instance_type = "t3.nano"
    key_name = "gmusic-bot-key"
    vpc_security_group_ids = ["${aws_security_group.discord_group.id}"]
    subnet_id = "${aws_subnet.discord_subnet.id}"
    user_data = "${data.template_file.user_data.rendered}"

    tags = {
        Name = "GMusic-Bot"
        Application = "Discord"
    }
}
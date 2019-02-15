resource "aws_iam_role" "discord_role" {
    name = "discord-role"
    assume_role_policy = "${data.aws_iam_policy_document.discord_assume_document.json}"
}

resource "aws_iam_role_policy" "discord_role_policy" {
    name = "discord-access-policy"
    role = "${aws_iam_role.discord_role.id}"
    policy = "${data.aws_iam_policy_document.discord_access_document.json}"
}
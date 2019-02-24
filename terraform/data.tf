data "aws_caller_identity" "current" {}

data "aws_ssm_parameter" "creds" {
    name = "${var.creds}"
    with_decryption = true
}

data "aws_ssm_parameter" "environment" {
    name = "${var.environment}"
    with_decryption = true
}

data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"]
}

data "template_file" "user_data" {
    template = "${file("./userdata.sh")}"

    vars = {
        ubuntu-dependencies = "${var.ubuntu_dependencies}"
        python-dependencies = "${var.python_dependencies}"
        username = "${var.instance_username}"
        environment = "${var.environment}"
        creds = "${var.creds}"
    }
}

data "aws_iam_policy_document" "discord_assume_document" {
    statement {
        actions = ["sts:AssumeRole"]
        
        principals {
            type = "Service"
            identifiers = ["ec2.amazonaws.com"]
        }
    }
}

data "aws_iam_policy_document" "discord_access_document" {
    statement {
        sid = "kmsCryptAccess"

        actions = [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:ReEncrypt",
        "kms:ListKeys"
        ]

        resources = [
            "arn:aws:kms:us-east-1:${data.aws_caller_identity.current.account_id}:*"
        ]
    }

    statement {
        sid = "ssmAccess"

        actions = [
            "ssm:DescribeParameters",
            "ssm:Get*"
        ]

        resources = [
            "arn:aws:ssm:us-east-1:${data.aws_caller_identity.current.account_id}:*"
        ]
    }
}
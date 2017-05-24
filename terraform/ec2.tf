resource "aws_kms_key" "main" {
  description = "${var.full_name} Encryption Key"
  policy = "${file("resources/key-policy.json")}"
}

resource "aws_kms_alias" "main" {
  name = "alias/${title(var.name)}"
  target_key_id = "${aws_kms_key.main.key_id}"
}

resource "aws_ami_copy" "main" {
  name = "CentOS 7 - Encrypted Root Volume - ${var.full_name}"
  source_ami_id = "ami-b60d87a1"
  source_ami_region = "us-east-1"
  encrypted = true
  kms_key_id = "${aws_kms_key.main.arn}"
}

resource "aws_instance" "main" {
  ami = "${aws_ami_copy.main.id}"
  instance_type = "m4.xlarge"
  disable_api_termination = true
  subnet_id = "${aws_subnet.data-node.id}"
  key_name = "Level-3-Launch"
  vpc_security_group_ids = ["${aws_security_group.data-node.id}"]

  tags {
    Name = "${var.full_name} Data Node"
  }
}

resource "aws_security_group" "data-node" {
  name = "${var.name}-data-node"
  vpc_id = "${aws_vpc.main.id}"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["10.0.1.87/32", "10.0.3.40/32"]
  }

  ingress {
    from_port = 5900
    to_port = 5910
    protocol = "tcp"
    cidr_blocks = ["10.0.1.87/32", "10.0.3.40/32"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.full_name} Data Node"
  }
}

resource "aws_security_group" "rds" {
  name = "${var.name}-rds"
  vpc_id = "${aws_vpc.main.id}"

  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"

    security_groups = ["sg-66cc6d1d", "sg-af7c70d4"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.full_name} PostgreSQL RDS"
  }
}

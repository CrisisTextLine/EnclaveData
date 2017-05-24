resource "aws_subnet" "data-node" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.cidr_data_node}"

  tags {
    Name = "Data Node - ${var.full_name}"
  }
}

resource "aws_subnet" "rds1" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.cidr_rds_1}"
  availability_zone = "us-east-1c"

  tags {
    Name = "RDS 1 - ${var.full_name}"
  }
}

resource "aws_subnet" "rds2" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.cidr_rds_2}"
  availability_zone = "us-east-1d"

  tags {
    Name = "RDS 2 - ${var.full_name}"
  }
}

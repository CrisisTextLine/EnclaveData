resource "aws_vpc" "main" {
  cidr_block = "${var.cidr}"

  tags {
    Name = "${var.long_name}"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "${var.full_name}"
  }
}

resource "aws_vpc_peering_connection" "main" {
  vpc_id = "vpc-5800c93f"
  peer_vpc_id = "${aws_vpc.main.id}"
  auto_accept = true

  tags {
    Name = "Level 3 Management <---> ${var.full_name}"
  }
}

resource "aws_route" "peer" {
  route_table_id = "${aws_vpc.main.main_route_table_id}"
  destination_cidr_block = "10.0.0.0/22"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.main.id}"
}

resource "aws_route_table" "external" {
  vpc_id = "${aws_vpc.main.id}"
  route {
    cidr_block = "10.0.0.0/22"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.main.id}"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }

  tags {
    Name = "${var.full_name} External"
  }
}

resource "aws_route" "management-edge" {
  route_table_id = "rtb-879ad2e0"
  destination_cidr_block = "${aws_vpc.main.cidr_block}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.main.id}"
}

resource "aws_route" "management-core" {
  route_table_id = "rtb-779bd310"
  destination_cidr_block = "${aws_vpc.main.cidr_block}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.main.id}"
}

resource "aws_route" "client-vpn" {
  route_table_id = "rtb-539bd334"
  destination_cidr_block = "${aws_vpc.main.cidr_block}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.main.id}"
}

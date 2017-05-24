resource "aws_db_subnet_group" "main" {
  name = "${var.name}-subnet"
  subnet_ids = ["${aws_subnet.rds1.id}", "${aws_subnet.rds2.id}"]
  description = "${var.full_name} RDS subnet"

  tags {
    Name = "${lower(var.full_name)} subnet"
  }
}

resource "aws_db_instance" "main" {
  engine = "postgres"
  engine_version = "9.6.1"
  instance_class = "db.m4.xlarge"
  storage_type = "gp2"
  allocated_storage = 1000
  identifier = "${var.name}-db"
  username = "${var.dbname}"
  password = "${var.dbpass}"
  db_subnet_group_name = "${aws_db_subnet_group.main.name}"
  publicly_accessible = false
  vpc_security_group_ids = ["${aws_security_group.rds.id}"]
  name = "enclave"
  storage_encrypted = true
  kms_key_id = "${aws_kms_key.main.arn}"
  backup_retention_period = 7
}

## Subnets
resource "aws_db_subnet_group" "subnet_group" {
  name = "subnet-group-${var.project_name}"
  subnet_ids = ["${aws_subnet.private_subnet.*.id}"]

  tags = {
    Name = "subnet-group-${var.project_name}"
    Environment = "${var.environment}"
    Project = "${var.project_name}"
  }
}

## Parameter Group
resource "aws_db_parameter_group" "parameter_group" {
  name = "parameter-group-${var.project_name}"
  description = "Parameter Group defined for ${var.project_name}"

  family = "${var.engine_family}"

  tags = {
    Name = "parameter-group-${var.project_name}"
    Environment = "${var.environment}"
    Project = "${var.project_name}"
  }
}

## RDS Instance
resource "aws_db_instance" "rds_instance" {
  allocated_storage = "${var.storage}"
  storage_type = "gp2"

  engine = "${var.engine}"
  engine_version = "${var.engine_version}"
  instance_class = "${var.instance_tier}"

  identifier = "rds-${var.project_name}-id"

  username = "${var.db_username}" # Master username
  password = "${var.db_password}"

  db_subnet_group_name = "${aws_db_subnet_group.subnet_group.id}"
  parameter_group_name = "${aws_db_parameter_group.parameter_group.id}"
  vpc_security_group_ids = ["${aws_security_group.sg_databases.id}"]

  publicly_accessible = false
  apply_immediately = "${var.apply_immediately}"
  copy_tags_to_snapshot = "${var.copy_tags_to_snapshot}"

  multi_az = "${var.multi_az}"
  availability_zone = "${element(var.availability_zones[var.aws_region], 0)}"

  backup_retention_period = "${var.retention}"
  backup_window = "04:00-05:00"

  final_snapshot_identifier = "final-snap-id-${var.project_name}"
  skip_final_snapshot = "${var.skip_final_snapshot}"

  maintenance_window = "Sat:02:15-Sat:03:15"
  # monitoring_role_arn = "${aws_iam_role.rds_enhanced_monitoring.arn}"
  # monitoring_interval = "10"

  tags = {
    Name = "rds-${var.project_name}"
    Environment = "${var.environment}"
    Project = "${var.project_name}"
  }
}

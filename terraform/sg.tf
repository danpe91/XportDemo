## ELB Security group
resource "aws_security_group" "sg_load_balancer" {
  name = "LoadBalancer"
  description = "Security Group for my load balancer"
  vpc_id = "${aws_vpc.vpc_demo.id}"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "sg-elb-demo"
    Environment = "${var.environment}"
    Project = "${var.project_name}"
  }
}

## EC2 Security group
resource "aws_security_group" "sg_instances" {
  name = "EC2Instances"
  description = "Security Group for my EC2 instances"
  vpc_id = "${aws_vpc.vpc_demo.id}"

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    security_groups = ["${aws_security_group.sg_load_balancer.id}"]
  }

  # # For testing and demoing purposes only
  # ingress {
  #   from_port = 80
  #   to_port = 80
  #   protocol = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["189.195.134.130/32"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "sg-ec2-demo"
    Environment = "${var.environment}"
    Project = "${var.project_name}"
  }
}

## RDS Security group
resource "aws_security_group" "sg_databases" {
  name = "Databases"
  description = "Security Group for RDS instances"
  vpc_id = "${aws_vpc.vpc_demo.id}"

  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    security_groups = ["${aws_security_group.sg_instances.id}"]
  }

  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["189.195.134.130/32"]
  }

  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = ["189.195.134.130/32"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "sg-rds-demo"
    Environment = "${var.environment}"
    Project = "${var.project_name}"
  }
}

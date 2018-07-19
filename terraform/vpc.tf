provider "aws" {
  region = "${var.aws_region}"
}

# AWS VPC
resource "aws_vpc" "vpc_demo" {
  cidr_block = "${var.vpc_cidr}"

  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-demo"
    Environment = "${var.environment}"
    Project = "${var.project_name}"
  }
}

## Subnets
#  Public
resource "aws_subnet" "public_subnet" {
  count = "${length(var.availability_zones[var.aws_region])}"

  vpc_id = "${aws_vpc.vpc_demo.id}"

  cidr_block = "${cidrsubnet(var.vpc_cidr, 8, count.index)}"
  availability_zone = "${element(var.availability_zones[var.aws_region], count.index)}"
  map_public_ip_on_launch = false

  tags {
    Name = "public-AZ-${element(var.availability_zones[var.aws_region], count.index)}"
    Environment = "${var.environment}"
    Project = "${var.project_name}"
  }
}

#  Private
resource "aws_subnet" "private_subnet" {
  count = "${length(var.availability_zones[var.aws_region])}"

  vpc_id = "${aws_vpc.vpc_demo.id}"

  cidr_block = "${cidrsubnet(var.vpc_cidr, 8, count.index + 100)}"
  availability_zone = "${element(var.availability_zones[var.aws_region], count.index)}"
  map_public_ip_on_launch = false

  tags {
    Name = "private-AZ-${element(var.availability_zones[var.aws_region], count.index)}"
    Environment = "${var.environment}"
    Project = "${var.project_name}"
  }
}

## Internet gateway
resource "aws_internet_gateway" "internet_gateway"{
  vpc_id = "${aws_vpc.vpc_demo.id}"

  tags {
    Name = "internet-gateway-demo"
    Environment = "${var.environment}"
    Project = "${var.project_name}"
  }
}

# ## NAT gateway
# resource "aws_eip" "nat_ip" {
#   count = "${length(var.availability_zones[var.aws_region])}"
#   vpc = true
# }
#
# resource "aws_nat_gateway" "nat_gw" {
#   count = "${length(var.availability_zones[var.aws_region])}"
#
#   allocation_id = "${element(aws_eip.nat_ip.*.id, count.index)}"
#   subnet_id = "${element(aws_subnet.public_subnet.*.id, count.index)}"
#
#   tags {
#     Name = "nat-gateway-${element(var.availability_zones[var.aws_region], count.index)}"
#     Environment = "${var.environment}"
#     Project = "${var.project_name}"
#   }
# }
#
## Table routes
#  Public
resource "aws_route_table" "public_routes" {
  vpc_id = "${aws_vpc.vpc_demo.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.internet_gateway.id}"
  }

  tags {
    Name = "public-table-route-demo"
    Environment = "${var.environment}"
    Project = "${var.project_name}"
  }
}

#  Private
resource "aws_route_table" "private_routes" {
  count = "${length(var.availability_zones[var.aws_region])}"
  vpc_id = "${aws_vpc.vpc_demo.id}"

  route {
    cidr_block = "0.0.0.0/0"
    # gateway_id = "${element(aws_nat_gateway.nat_gw.*.id, count.index)}"
    gateway_id = "${aws_internet_gateway.internet_gateway.id}"
  }

  tags {
    Name = "private-table-riytes-${element(var.availability_zones[var.aws_region], count.index)}"
    Environment = "${var.environment}"
    Project = "${var.project_name}"
  }
}

## Routing
#  Public
resource "aws_route_table_association" "public_routing_table" {
  count = "${length(var.availability_zones[var.aws_region])}"

  subnet_id = "${element(aws_subnet.public_subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.public_routes.id}"

  # tags {
  #   Name = "public-route-table-association-${element(var.availability_zones[var.aws_region], count.index)}"
  #   Environment = "${var.environment}"
  #   Project = "${var.project_name}"
  # }
}

#  Private
resource "aws_route_table_association" "private_routing_table" {
  count = "${length(var.availability_zones[var.aws_region])}"

  subnet_id = "${element(aws_subnet.private_subnet.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private_routes.*.id, count.index)}"

  # tags {
  #   Name = "private-route-table-association-${element(var.availability_zones[var.aws_region], count.index)}"
  #   Environment = "${var.environment}"
  #   Project = "${var.project_name}"
  # }
}

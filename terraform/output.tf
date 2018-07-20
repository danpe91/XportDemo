## VPC
output "vpc_id" {
  description = "ID of the VPC created"
  value = "${aws_vpc.vpc_demo.id}"
}

output "vpc_cidr" {
  description = "CIDR used for the VPC"
  value = "${aws_vpc.vpc_demo.cidr_block}"
}

output "public_subnets" {
  description = "List of public subnets"
  value = ["${aws_subnet.public_subnet.*.id}"]
}

output "private_subnets" {
  description = "List of private subnets"
  value = ["${aws_subnet.private_subnet.*.id}"]
}

# output "public_routing_table_id" {
#   description = "ID of the public routing table"
#   value = "${aws_route_table.public_routes.id}"
# }
#
# output "private_routing_table_id" {
#   description = "List of private routing tables"
#   value = ["${aws_route_table.private_routes.*.id}"]
# }

output "region_availability_zones" {
  description = "List of availability zones in selected region"
  value = ["${var.availability_zones[var.aws_region]}"]
}


## Security Groups
output "sg_alb_id" {
  description = "Returns the ID of the ELB's Security Group."
  value       = "${aws_security_group.sg_load_balancer.id}"
}

output "sg_ec2_id" {
  description = "Returns the ID of the EC2's Security Group."
  value       = "${aws_security_group.sg_instances.id}"
}

output "sg_rds_id" {
  description = "Returns the ID of the RDS's Security Group."
  value       = "${aws_security_group.sg_databases.id}"
}


## Application Load Balancer
output "alb_id" {
  description = "Returns the ID of the created Application Load Balancer"
  value = "${aws_lb.application_load_balancer.id}"
}

output "alb_arn" {
  description = "Returns the ARN of the Application Load Balancer."
  value       = "${aws_lb.application_load_balancer.arn}"
}

output "alb_listener_id" {
  description = "Returns the ID of the HTTP listener attached in the ALB."
  value       = "${aws_lb_listener.lb_listener.id}"
}

output "alb_listener_arn" {
  description = "Returns the ARN of the HTTP listener attached in the ALB."
  value       = "${aws_lb_listener.lb_listener.arn}"
}

output "alb_dns_name" {
  description = "Returns the ARN of the HTTP listener attached in the ALB."
  value       = "${aws_lb.application_load_balancer.dns_name }"
}


## ALB Target Group
output "alb_tg_be_id" {
  description = "Application Load Balancer - Target Group ID"
  value       = "${aws_lb_target_group.target_group.id}"
}

output "alb_tg_be_arn" {
  description = "Application Load Balancer - Target Group  ARN"
  value       = "${aws_lb_target_group.target_group.arn}"
}


## Auto Scaling group
output "asg_id" {
  description = "ID of the Auto Scaling Group"
  value       = "${aws_autoscaling_group.autoscaling.id}"
}

output "asg_arn" {
  description = "ARN of the Auto Scaling Group"
  value       = "${aws_autoscaling_group.autoscaling.arn}"
}

output "asg_name" {
  description = "Name of the Auto Scaling Group"
  value       = "${aws_autoscaling_group.autoscaling.name}"
}

output "asg_lc" {
  description = "Name of the Launch Configuration used in the Autoscaling Group"
  value       = "${aws_autoscaling_group.autoscaling.launch_configuration}"
}

output "asg_lbs" {
  description = "List with the IDs of the Load Balancers assigned for the Autoscaling Group."
  value       = "${aws_autoscaling_group.autoscaling.load_balancers}"
}

## RDS
output "subnet_group_id" {
  description = "Get the ID of for the Subnet Group."
  value       = "${aws_db_subnet_group.subnet_group.id}"
}

output "parameter_group_id" {
  description = "Get the ID of for the Parameter Group."
  value       = "${aws_db_parameter_group.parameter_group.id}"
}

output "subnet_group_arn" {
  description = "Get the ARN of for the Subnet Group."
  value       = "${aws_db_subnet_group.subnet_group.arn}"
}

output "parameter_group_arn" {
  description = "Get the ARN of for the Parameter Group."
  value       = "${aws_db_parameter_group.parameter_group.arn}"
}

output "instance_id" {
  description = "Get the ID of for the RDS instance."
  value       = "${aws_db_instance.rds_instance.id}"
}

output "endpoint" {
  description = "Get the Endpoint of for the RDS instance."
  value       = "${aws_db_instance.rds_instance.endpoint}"
}

output "address" {
  description = "Get the Address of for the RDS instance."
  value       = "${aws_db_instance.rds_instance.address}"
}

output "status" {
  description = "Get the Status of for the RDS instance."
  value       = "${aws_db_instance.rds_instance.status}"
}

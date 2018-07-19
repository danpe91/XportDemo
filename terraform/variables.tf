# VPC variables
variable "aws_region" {
  description = "Seletc Amazon region"
  default = "us-west-1"
}

variable "vpc_cidr" {
  description = "CIDR block used for the VPC"
  default = "18.0.0.0/16"
}

variable "project_name" {
  description = "Logical name for project, used as prefix on created resources"
  type = "string"
  default = "demo"
}

variable "environment" {
  description = "Environment used on the project, used on tags for created resources"
  type = "string"
  default = "test"
}

variable "availability_zones" {
  description = "Availability zones for different regions"
  type = "map"
  default = {
    us-east-1 = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"]
    us-east-2 = ["us-east-2a", "us-east-2b", "us-east-2c"]
    us-west-1 = ["us-west-1a", "us-west-1b"]
    us-west-2 = ["us-west-2a", "us-west-2b", "us-west-2c"]
    ca-central-1 = ["ca-central-1a", "ca-central-1b"]
    sa-east-1 = ["sa-east-1a", "sa-east-1c"]
  }
}

# variable "vpc_id" {
#   description = "Define the VPC where the Security Group is created"
#   type = "string"
#   default = "aws_vpc.vpc_demo.id"
# }

# variable "public_ip" {
#   description = "The IPS for the instances"
#   type = "list"
# }

# variable "public_subnets" {
#   description = "List of all the subnets for the Application Load Balancer"
#   type = "list"
#   default = ["aws_subnet.public_subnet.*.id"]
# }

variable "security_group_alb_id" {
  description = "List of the security groups to be attached"
  type = "string"
  default = "aws_security_group.sg_load_balancer.id"
}

# variable "security_group_ec2_id" {
#   description = "List of the security groups to be attached"
#   type = "string"
#   default = "aws_security_group.sg_instances.id"
# }

# variable "target_group_arn" {
#   description = "Defines the target group to send the traffic"
#   type = "string"
#   default = "aws_lb_target_group.target_group.arn"
# }


variable "server_ami" {
  description = "A Map containing the selectable AMIs for each region"
  type = "map"
  default = {
    us-east-1 = "ami-6871a115"
    us-east-2 = "ami-03291866"
    us-west-1 = "ami-18726478"
    us-west-2 = "ami-28e07e50"
    ca-central-1 = "ami-49f0762d"
    sa-east-1 = "ami-b0b7e3dc"
  }
}

variable "instance_type" {
  description = "The instance type for creating EC2 instances"
  type = "string"
  default = "t2.micro"
}
variable "desired_capacity" {
  description   = "The number of instances to start the Autoscaling."
  type          = "string"
  default = "1"
}

variable "max_size" {
  description   = "The max number of instances to scale the Autoscaling."
  type          = "string"
  default = "1"
}

variable "min_size" {
  description   = "The min number of instances to scale the Autoscaling."
  type          = "string"
  default = "1"
}

# variable "user_data" {
#   description = "UserData script to execute on EC2 instances"
#   type = "string"
#   # default = "${file("./user-data.sh")}"
#   default = "asdss"
# }

variable "public_key" {
  description = "Public SSH key for connecting to EC2 instances"
  type = "string"
  # default = "${file("./id_rsa.pub")}"
  default = "sww"
}

variable "engine" {
  description = "Engine for RDS Database instance"
  type = "string"
  default = "postgres"
}

variable "engine_version" {
  description = "Engine version for RDS Database instance"
  type = "string"
  default = "9.6"
}

variable "engine_family" {
  description = "Engine family for the Database"
  type = "string"
  default = "postgres9.6"
}

variable "storage" {
  description = "This variable define the Storage allocated for the RDS instance"
  type = "string"
  default = "10"
}

variable "instance_tier" {
  description = "Type of RDS Instance to be created"
  type = "string"
  default = "db.t2.micro"
}

variable "db_username" {
  description = "Full-Access username for RDS Database"
  type = "string"
  default = "demouser"
}

variable "db_password" {
  description = "Password for the user"
  type = "string"
  default = "really$23423$secure$trefr45$pasword$q2123$"
}

# variable "vpc_security_group_ids" {
#   description = "List of the security groups that will be attached on the RDS instance"
#   type = "list"
#   default = "aws_security_group.sg_databases.id"
# }

variable "apply_immediately" {
  description   = "Method to be used for the changes [immediately could cause downtime for several minutes]"
  default       = false
}

variable "multi_az" {
  description   = "Select if should use Multi-AZ"
  default       = false
}

# variable "availability_zone" { DELETE
#   description   = "Availability zone of your preference." DELETE
#   type          = "string" DELETE
#   default = "var.availability_zones[var.aws_region]" DELETE
# } DELETE

variable "copy_tags_to_snapshot" {
  description = "On delete, copy all Instance tags to the final snapshot"
  default = false
}

variable "skip_final_snapshot" {
  description = "Determines whether skipping the creation of the final DB snapshot before the DB instance is deleted"
  default = true
}

variable "retention" {
  description   = "Number of days for Backup retention"
  type = "string"
  default       = "0"
}

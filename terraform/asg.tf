## SSH key
resource "aws_key_pair" "public_key" {
  key_name = "asg-my-key-${var.project_name}"
  public_key = "${file("./id_rsa.pub")}"
}

## Launch configuration
resource "aws_launch_configuration" "lc_demo" {
  name = "lc-${var.project_name}"
  key_name = "${aws_key_pair.public_key.key_name}"
  image_id = "${var.server_ami[var.aws_region]}"
  instance_type = "${var.instance_type}"
  associate_public_ip_address = true

  security_groups = ["${aws_security_group.sg_instances.id}"]

  user_data = "${file("./user-data.sh")}"
}

## Placement Group
resource "aws_placement_group" "pg_demo" {
  name = "pg-${var.project_name}"
  strategy = "spread"
}

## ASG
resource "aws_autoscaling_group" "autoscaling" {
  depends_on = ["aws_launch_configuration.lc_demo"]

  # availability_zones = ["${var.availability_zones[var.aws_region]}"]
  name = "autoscaling-${var.project_name}"
  desired_capacity = "${var.desired_capacity}"
  max_size = "${var.max_size}"
  min_size = "${var.min_size}"

  health_check_grace_period = 300

  target_group_arns = ["${aws_lb_target_group.target_group.arn}"]
  health_check_type = "EC2"
  force_delete = true
  placement_group = "${aws_placement_group.pg_demo.id}"
  launch_configuration = "${aws_launch_configuration.lc_demo.name}"

  vpc_zone_identifier = ["${aws_subnet.public_subnet.*.id}"]
  enabled_metrics = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]

  tags  = [{
    key = "Name"
    value = "autoscaling-${var.project_name}"
    propagate_at_launch = true
  }, {
    key = "Environment"
    value = "${var.environment}"
    propagate_at_launch = true
  }, {
    key = "Project"
    value = "${var.project_name}"
    propagate_at_launch = true
  }]
}

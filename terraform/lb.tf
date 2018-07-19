## Application Load Balancer
resource "aws_lb" "application_load_balancer" {
    name = "alb-demo"
    internal = false
    security_groups = ["${aws_security_group.sg_load_balancer.id}"]
    subnets = ["${aws_subnet.public_subnet.*.id}"]

    enable_http2 = true

    tags {
      Name = "alb-demo"
      Environment = "${var.environment}"
      Project = "${var.project_name}"
    }
}

# Listeners
resource "aws_lb_listener" "lb_listener" {
    load_balancer_arn = "${aws_lb.application_load_balancer.arn}"
    port = "80"
    protocol = "HTTP"

    default_action {
      target_group_arn = "${aws_lb_target_group.target_group.arn}"
      type = "forward"
    }
}

## Target Groups
resource "aws_lb_target_group" "target_group" {
  name = "tg-demo"
  port = 80
  protocol = "HTTP"
  vpc_id = "${aws_vpc.vpc_demo.id}"
  deregistration_delay = 60

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 5
    timeout = 5
    interval = 15
    protocol = "HTTP"
    matcher = "200,202,301,304"
    path = "/"
  }

  stickiness {
    type = "lb_cookie"
    cookie_duration = "43200"
    enabled = true
  }

  tags {
    Name = "tg-demo"
    Environment = "${var.environment}"
    Project = "${var.project_name}"
  }
}

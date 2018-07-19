## Database creation
provider "postgresql" {
  alias    = "psql_provider"
  host     = "${aws_db_instance.rds_instance.address}"
  username = "${var.db_username}"
  password = "${var.db_password}"
  sslmode = "disable"
}

resource "postgresql_database" "demo_database" {
  provider = "postgresql.psql_provider"
  depends_on = ["aws_db_instance.rds_instance"]
  name              = "demo_database"
  owner             = "${var.db_username}"
  template          = "template0"
  lc_collate        = "C"
  connection_limit  = -1
  allow_connections = true
}

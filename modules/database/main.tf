resource "google_sql_database" "database" {
  name     = "${var.project}-db-${var.environment}"
  instance = google_sql_database_instance.instance.name
}

resource "google_sql_database_instance" "instance" {
  name             = "${var.project}-instance-${var.environment}"
  region           = var.region
  database_version = var.databaseVersion
  settings {
    tier = var.databaseTier
  }
  deletion_protection  = "true"
}
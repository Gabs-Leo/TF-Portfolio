resource "google_secret_manager_secret" "secret-basic" {
  secret_id = "${var.project}-secret-${var.environment}"

  labels = {
    label = "${var.project}-secret-${var.environment}"
  }

  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }
}
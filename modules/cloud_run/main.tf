resource "google_cloud_run_service" "cloud_run" {
  name     = "${var.project}-${var.region}-${var.environment}"
  location = var.region

  template {
    metadata {
      annotations = {
        "run.googleapis.com/execution-environment" = "gen2"
      }
    }
    spec {
      #service_account_name = "fs-identity"
      containers {
        image = var.registryUrl
        env {
          #name = "BUCKET"
          #value = var.bucket
          name = "APP_PORT"
          value = "80"
        }
        ports {
          container_port = 80
        }
      }
    }
  }
  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location    = google_cloud_run_service.cloud_run.location
  project     = google_cloud_run_service.cloud_run.project
  service     = google_cloud_run_service.cloud_run.name

  policy_data = data.google_iam_policy.noauth.policy_data
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}
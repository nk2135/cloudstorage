
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.64.0"
    }
  }
}


provider "google" {
  credentials = file("C:/scripts/GCP/smooth-league-275317-2f4f661b039f.json")
  project     = "smooth-league-275317"
  region      = "us-central1"
}
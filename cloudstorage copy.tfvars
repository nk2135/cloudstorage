/*# Basic Bucket Configuration
bucket_name = "pbmdchghc001"
location    = "US"
storage_class = "STANDARD"

# Bucket Features
versioning = true
labels = {
  "env"  = "production"
  "team" = "devops"
}

# Access Control
uniform_bucket_level_access = true

# Bucket Lifecycle Rules
lifecycle_rules = [
  {
    age = 30
    with_state = "ANY"
    condition = {
      created_before = "2023-01-01"
    }
    action = {
      type = "DELETE"
    }
  },
  {
    age = 365
    with_state = "ANY"
    action = {
      type          = "SET_STORAGE_CLASS"
      storage_class = "COLDLINE"
    }
  }
]

# CORS Configuration
cors_rules = [
  {
    origin          = ["*"]
    method          = ["GET", "HEAD"]
    response_header = ["*"]
    max_age_seconds = 3600
  }
]

# Example IAM Bindings (if you're using them)
bucket_iam_bindings = {
  "roles/storage.objectViewer" = ["nk2135@gmail.com"]
}

# ... Add additional variable values as needed ...*/

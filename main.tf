resource "google_storage_bucket" "main_bucket"{
    name                = var.bucket_name
    location            = var.location
    storage_class       = var.storage_class
    labels              = var.labels

        versioning {
          enabled = var.versioning
        }

}

uniform_bucket_level_access = var.uniform_bucket_level_access

dynamic "lifecycle_rule"{
    for_each = var.lifecycle_rule
    content {
        condition{
            age                     = lifecycle_rule.value.age
            with_state              = lifecycle_rule.value.with_state
            created_before          = lookup(lifecycle_rule.value.condition, "created_before", null)
            matches_storage_class   = lookup(lifecycle_rule.value.condition, "matches_storage_class",null)

        }
        action{
            type    = lifecycle_rule.value.action.type
            storage_class = lookup(lifecycle_rule.value.action, "storage_class",null)
        }
    }
}

dynamic "cors"{
    for_each = var.cors_rules
    content {
        origin              = cors.value.origin
        method              = cors.value.method
        response_header     = cors.value.response_header
        max_age_seconds     = cors.value.max_age_seconds
    }
}

# Additional settings like encryption,logging, etc. can be added similarly.

#if you are using IAM bindings:

resource "google_storage_bucket_iam_binding" "bucket_iam" {

    for_each        = var.bucket_iam_bindings  
    bucket          = google_storage_bucket.main_bucket.name
    members         = each.value.members
}
  

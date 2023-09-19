variable "bucket_name" {
  description = "The name of the bucket."
  type        = string
}

variable "location" {
  description = "The location of the bucket."
  type        = string
  default     = "US"
}

variable "storage_class" {
  description = "The storage class of the bucket."
  type        = string
  default     = "STANDARD"
}

variable "versioning" {
  description = "Whether or not to enable versioning."
  type        = bool
  default     = false
}

variable "labels" {
  description = "Labels to assign to the bucket."
  type        = map(string)
  default     = {}
}

variable "uniform_bucket_level_access" {
  description = "Whether or not to enable uniform bucket-level access."
  type        = bool
  default     = false
}
variable "lifecycle_rule" {
    description = "Lifecycle rules for the bucket"
    type = list(object({
        condition = object({
            age                   = optional(number)
            with_state            = optional(string)
            created_before        = optional(string)
            matches_storage_class = optional(list(string))
        })
        action = object({
            type          = string
            storage_class = optional(string)
        })
    }))
    default = []
}


variable "cors_rules" {
    description = "CORS rules for the bucket"
    type = list(object({
        origin          = list(string)
        method          = list(string)
        response_header = list(string)
        max_age_seconds = number
    }))
    default = []
}

# ... add other variables as needed ...

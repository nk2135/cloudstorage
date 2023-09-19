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

# ... add other variables as needed ...

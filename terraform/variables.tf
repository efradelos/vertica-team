variable "team" {
  description = "Name of team"
}

variable "cloud_backend_bucket" {
  description = "Name of s3 bucket that contains terraform state data for infrastructure"
}

variable "cloud_backend_key" {
  description = "Key within s3 bucket that contains terraform state data for infrastructure"
}

variable "cloud_backend_region" {
  description = "Region of s3 bucket that contains terraform state data for infrastructure"
}

variable "ssh_key_path" {
  description = "Path to public key to upload to aws"
}

variable "db_user" {
  description = "The name of the db user account"
}

variable "db_name" {
  description = "The name of the database"
}

variable "mc_username" {
  description = "Username for logging into Management Console"
}

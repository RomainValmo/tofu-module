variable "gcp_project_id" {
    description = "The GCP project ID"
    type = string
}

variable "gcp_region" {
    description = "The GCP region"
    type = string
    default = "europe-west1"
}

variable "gcp_credentials_file" {
    description = "The GCP credentials file"
    type = string
}

variable "worker" {
  type = map(object({
    instance_type    = string
    zone    = string
    allow_stopping_for_update    = bool
    image    = string
    size_disk    = number
    disk_type    = string
    ssh-host    = string
    ssh-file    = string
  }))
}

variable "masternode" {
  type = map(object({
    instance_type    = string
    zone    = string
    allow_stopping_for_update    = bool
    image    = string
    size_disk    = number
    disk_type    = string
    ssh-host    = string
    ssh-file    = string
  }))
}

variable "private_key_ssh" {
    description = "Path to the private key"
    type        = string
  
}

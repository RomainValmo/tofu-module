variable "gcp_credentials_file" {
    description = "path to your Json file"
    type        = string
    default = "./gcp.json"
}

variable "gcp_project_id" {
    description = "Google Cloud Project ID"
    type        = string
}

variable "gcp_region" {
    description = "Google Cloud Region"
    type        = string
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
    default = {
      "worker1" = {
        instance_type = "e2-medium"
        zone = "europe-west1-b"
        allow_stopping_for_update = true
        image = "ubuntu-2004-focal-v20241219"
        size_disk = 20
        disk_type = "pd-standard"
        ssh-host = "host"
        ssh-file = "./ssh.pub"
        
      }
    }
}

variable "tag_worker"{
    type = list(string)
    description = "value of the tag for the worker node"
    default = ["kube-node-port-worker"]
  
}

variable "tag_masternote"{
    type = list(string)
    description = "value of the tag for the master node"
    default = ["kube-node-port-masternode"]
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
  default = {
    "masternode1" = {
        instance_type = "e2-medium"
        zone = "europe-west1-b"
        allow_stopping_for_update = true
        image = "ubuntu-2004-focal-v20241219"
        size_disk = 20
        disk_type = "pd-standard"
        ssh-host = "host"
        ssh-file = "./ssh.pub"
    }
  }

}

variable "private_key_ssh" {
    description = "Path to the private key"
    type        = string
    default = "./ssh"
  
}

variable "network_ip_range" {
    description = "Network IP range"
    type        = string
    default = "10.132.0.0/20"
  
}
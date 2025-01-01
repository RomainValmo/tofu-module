variable "aws_access_key" {
    type = string
  
}

variable "aws_secret_key" {
    type = string
  
}

variable "masternode" {
  type = map(object({
    instance_type             = string
    ami                       = string
    zone                      = string
    size_disk                 = number
    disk_type                 = string
    device_name               = string
    allow_stopping_for_update = bool
  }))
  description = "Map of the master node"

  default = {
    "master1" = {
      instance_type             = "t2.medium"
      zone                      = "eu-west-3a"
      ami                       = "ami-01837272e705da171"
      size_disk                 = 20
      disk_type                 = "standard"
      device_name               = "/dev/xvda"
      allow_stopping_for_update = true
    }
  }
}

variable "workernode" {
  type = map(object({
    instance_type             = string
    ami                       = string
    zone                      = string
    size_disk                 = number
    disk_type                 = string
    device_name               = string
    allow_stopping_for_update = bool
  }))
  description = "Map of the master node"

  default = {
    "worker1" = {
      instance_type             = "t2.medium"
      zone                      = "eu-west-3a"
      ami                       = "ami-01837272e705da171"
      size_disk                 = 20
      disk_type                 = "standard"
      device_name               = "/dev/xvda"
      allow_stopping_for_update = true
    }
  }
}

variable "ssh_key" {
  type        = string
  default     = "./ssh.pub"
  description = "Path to your SSh key public"

}

variable "ssh_private_key" { 
    type        = string
    default     = "./ssh"
    description = "Path to your SSh key private"
  
}
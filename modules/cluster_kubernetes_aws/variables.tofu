variable "aws_access_key" {
  type    = string
  default = "YOUR_ACCESS_KEY"
}

variable "aws_secret_key" {
  type    = string
  default = "YOUR_SECRET_KEY"
}

variable "aws_region" {
  type    = string
  default = "eu-west-3"

}

variable "ssh_key" {
  type        = string
  default     = "./ssh.pub"
  description = "Path to your SSh key public"

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



variable "ssh_host" {
  type        = string
  description = "SSH user"
  default     = "ubuntu"
}

variable "private_key_ssh" {
  description = "Path to the private key"
  type        = string
  default     = "./ssh"

}

variable "network_ip_range" {
  type    = string
  default = "10.132.0.0/16"

}

variable "subnet_ip_range" {
  type    = string
  default = "10.132.0.0/20"
}

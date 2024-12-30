resource "aws_vpc" "kube_aws" {
  cidr_block           = var.network_ip_range
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "kube-vpc"
  }
}

resource "aws_subnet" "kube_aws_subnet" {
  vpc_id                  = aws_vpc.kube_aws.id
  cidr_block              = var.subnet_ip_range
  map_public_ip_on_launch = true
  tags = {
    Name = "kube-subnet"
  }
}

resource "aws_internet_gateway" "kube_igw" {
  vpc_id = aws_vpc.kube_aws.id
}

resource "aws_route_table" "kube_route_table" {
  vpc_id = aws_vpc.kube_aws.id
}

resource "aws_route" "route_to_igw" {
  route_table_id         = aws_route_table.kube_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.kube_igw.id
}

resource "aws_route_table_association" "kube_subnet_association" {
  subnet_id      = aws_subnet.kube_aws_subnet.id
  route_table_id = aws_route_table.kube_route_table.id
}



resource "aws_security_group" "kube_worker_sg" {
  name        = "kube-worker-sg"
  description = "Allow traffic for Kubernetes worker nodes"
  vpc_id      = aws_vpc.kube_aws.id

  ingress {
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "kube-worker-sg"
  }
}

resource "aws_security_group" "kube_master_sg" {
  name        = "kube-master-sg"
  description = "Allow traffic for Kubernetes master nodes"
  vpc_id      = aws_vpc.kube_aws.id

  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = [var.network_ip_range]
  }

  ingress {
    from_port   = 10250
    to_port     = 10255
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }

  ingress {
    from_port   = 2379
    to_port     = 2380
    protocol    = "tcp"
    cidr_blocks = [var.network_ip_range]
  }

  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "kube-master-sg"
  }
}

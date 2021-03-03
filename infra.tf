provider "aws" {
  region = "us-east-2"
}

terraform {
  backend "s3" {
    bucket = "thinknyx"
	key = "k8s_infra.tfstate"
	region = "us-east-2"
  }
}

variable "server" {
  description = "Give the number of Cluster to be prepared"
  type = number
}

resource "aws_instance" "k8s_master" {
  ami = "ami-0996d3051b72b5b2c"
  instance_type = "t2.medium"
  key_name = "kul-labs"
  tags = {
    "Name" = "k8s_master"
  }
  count = var.server
}

resource "aws_instance" "k8s_node" {
  ami = "ami-0996d3051b72b5b2c"
  instance_type = "t2.micro"
  key_name = "kul-labs"
  tags = {
    "Name" = "k8s_node"
  }
  count = var.server
}

output "public_ips_master" {
  value = aws_instance.k8s_master.*.public_ip
}
output "public_ips_node" {
  value = aws_instance.k8s_node.*.public_ip
}
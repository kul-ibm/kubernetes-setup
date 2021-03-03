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

resource "aws_instance" "k8s_master" {
  ami = "ami-0996d3051b72b5b2c"
  instance_type = "t2.medium"
  key_name = "kul-labs"
  tags = {
    "Name" = "k8s_master"
  }
  count = 26
  
  provisioner "remote-exec" {
    connection {
        type = "ssh"
        user = "ubuntu"
        host = self.public_ip
        private_key = file("c:/training/kul-labs.pem")
    }
    inline = [
        "sudo apt-get update -y",
        "sudo apt-get install -y ansible",
        "ansible --version",
        "mkdir -p ~/ansible",
        "echo '[master]' > ~/ansible/hosts && echo '${self.private_ip}' >> ~/ansible/hosts"
    ]
  }
}

output "public_ips_master" {
  value = aws_instance.k8s_master.*.public_ip
}
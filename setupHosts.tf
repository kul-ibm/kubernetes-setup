resource "null_resource" "setupHosts" {
  count = 26
  provisioner "remote-exec" {
    connection {
        type = "ssh"
        user = "ubuntu"
        host = aws_instance.k8s_master[count.index].public_ip
        private_key = file("c:/training/kul-labs.pem")
    }
    inline = [
        "echo '[master]' > ~/ansible/hosts",
        "echo '${aws_instance.k8s_master[count.index].private_ip}' >> ~/ansible/hosts",
        "echo '[nodes]' >> ~/ansible/hosts",
        "echo '${aws_instance.k8s_node[count.index].private_ip}' >> ~/ansible/hosts"
    ]
  }
}
resource "null_resource" "chmodPEM" {
  count = 26
  depends_on = [ null_resource.moveFiles ]
  provisioner "remote-exec" {
    connection {
        type = "ssh"
        user = "ubuntu"
        host = aws_instance.k8s_master[count.index].public_ip
        private_key = file("c:/training/kul-labs.pem")
    }
    inline = [
        "chmod 400 ~/ansible/kul-labs.pem"
    ]
  }
}
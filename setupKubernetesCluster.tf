resource "null_resource" "setupKubernetesCluster" {
  depends_on = [ null_resource.setupHosts ]
  count = var.server
  provisioner "remote-exec" {
    connection {
        type = "ssh"
        user = "ubuntu"
        host = aws_instance.k8s_master[count.index].public_ip
        private_key = file("c:/training/kul-labs.pem")
    }
    inline = [
        "git clone https://github.com/kul-ibm/kubernetes-setup.git",
        "cd kubernetes-setup && ansible-playbook kubernetes_setup.yml"
    ]
  }
}
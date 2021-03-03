resource "null_resource" "moveFiles" {
  count = 26
  depends_on = [ aws_instance.k8s_master ]
  provisioner "file" {
    connection {
        type = "ssh"
        user = "ubuntu"
        host = aws_instance.k8s_master[count.index].public_ip
        private_key = file("c:/training/kul-labs.pem")
    }
    source = "c:/training/kul-labs.pem"
    destination = "~/ansible/kul-labs.pem"
  }

   provisioner "file" {
     connection {
       type = "ssh"
       user = "ubuntu"
       host = aws_instance.k8s_master[count.index].public_ip
       private_key = file("c:/training/kul-labs.pem")
     }
     source = "ansible.cfg"
     destination = "~/ansible/ansible.cfg"
   }
}
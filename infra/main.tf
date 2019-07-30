resource "aws_instance" "quintoandar" {
  ami              = "${lookup(var.amis, var.aws_region)}"
  instance_type    = "${var.instance_type}"
  security_groups  = ["sg_DefaultWebserver"]
  key_name         = "${var.key_name}"
  user_data        = "${file("dckr.sh")}"

  tags = {
    Name           = "quintoandar"
    Provider       = "terraform"
    Role           = "test"
  }

  provisioner "file" { 
    connection {
      type	   = "ssh"
      host	   = self.public_ip
      user	   = "ec2-user"
      private_key  = "${file("quintoandar.pem")}"
    }
 
    source	   = "./"
    destination	   = "/home/ec2-user/"
  }

  provisioner "remote-exec" {
    connection {
      type	   = "ssh"
      host	   = self.public_ip
      user	   = "ec2-user"
      private_key  = "${file("quintoandar.pem")}"
    }

    inline = [
      "docker-compose up -d"
    ]
  }
}

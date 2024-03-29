resource "aws_security_group" "sg_DefaultWebserver" {
  name        = "sg_DefaultWebserver"
  description = "Allow all outbound traffic and inbound 22/8000/15672"

  ingress {
    from_port    = 22
    to_port      = 22
    protocol     = "tcp"
    cidr_blocks  = ["0.0.0.0/0"]
  }

  ingress {
    from_port     = 8000
    to_port       = 8000
    protocol      = "tcp"
    cidr_blocks   = ["0.0.0.0/0"]
  }

  ingress {
    from_port	  = 15672
    to_port	  = 15672
    protocol	  = "tcp"
    cidr_blocks   = ["0.0.0.0/0"]
  }


  egress {
    from_port     = 0
    to_port       = 0
    protocol      = "-1"
    cidr_blocks   = ["0.0.0.0/0"]
  }

  tags = {
    Name          = "sg_DefaultWebserver"
    Provisioner   = "terraform"
  }
}

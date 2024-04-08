######..."data source for retrieve aws ami_id"...######

data "aws_ami" "amazonaminame" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}

############...............module for EC2.........############

resource "aws_instance" "web" {
  ami                    = data.aws_ami.amazonaminame.id
  vpc_security_group_ids = [aws_security_group.allow.id]
  instance_type          = var.OStype
  tags = {
    Name = var.tagname
  }
}

variable "tagname" {
  type = string
  default = "os-by-terraform-remoteState_locking"

}

variable "OStype" {
   default = "t2.micro"

}

###########  "Module for security group which allow inbound rule" #########

resource "aws_security_group" "allow" {
  name        = "terra_allow_${var.security_grp_name}"
  description = " allow inbound "
  vpc_id      = var.vpcID

    dynamic "ingress" {
     for_each = var.sgports
     iterator = port
       content {
           description = "TLS from vpc"
           from_port    = port.value
           to_port     = port.value
           protocol    = "tcp"
           cidr_blocks = ["0.0.0.0/0"]
        }
    }

    egress {
       from_port    = 0
       to_port     = 0
       protocol    = "-1"
       cidr_blocks = ["0.0.0.0/0"]
    }

}


variable "sgports" {
  type    = list(number)
  default = [22, 8080, 80, 1234]
}


variable "security_grp_name" {
      type    = string
      default = "pratik-sg"

}

 ### "varible for VPC id "

variable "vpcID" {
    default = "vpc-071ddf3f50a17a539"

}

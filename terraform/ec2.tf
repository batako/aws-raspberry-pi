data "aws_vpc" "default" {
  filter {
    name   = "isDefault"
    values = [true]
  }
}

data "aws_ami" "base" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = [var.base_ami_name]
  }
}

resource "aws_security_group" "dev" {
  name        = var.ec2_name
  description = "To check the operation of the created AMI"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "For maintenance"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_cidr_block]
  }

  ingress {
    description = "For checking the behavior of Rails"
    from_port   = 3000
    to_port     = 3000
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
    Terraform   = "true"
    Environment = "dev"
  }
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

locals {
  subnet_id = element(tolist(data.aws_subnet_ids.default.ids), 0)
}

module "ec2_cluster" {
  source                 = "./modules/terraform-aws-ec2-instance"

  name                   = var.ec2_name
  ami                    = data.aws_ami.base.id
  instance_type          = "t2.micro"
  key_name               = var.key_pair_name
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.dev.id]
  subnet_ids             = [local.subnet_id]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

source "amazon-ebs" "example" {
  region        = var.region
  ami_name      = "${var.ami_name}_${formatdate("YYYY-MM-DD-hhmm", timestamp())}"
  instance_type = var.instance_type
  ssh_username  = var.ssh_username

  source_ami_filter {
    filters = {
      name = "amzn2-ami-hvm-*-x86_64-gp2"
    }
    owners      = ["137112412989"]
    most_recent = true
  }

  tags = {
    Name        = "${var.ami_name}_${formatdate("YYYY-MM-DD-hhmm", timestamp())}"
    Packer      = "true"
    Environment = var.environment
  }
}

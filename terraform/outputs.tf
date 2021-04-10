output "aws_vpc" {
  description = "Default VPC"
  value       = data.aws_vpc.default
}

output "aws_ami" {
  description = "The AMI from which it was created"
  value       = data.aws_ami.base
}

output "aws_security_group" {
  description = "Security groups tied to EC2"
  value       = aws_security_group.dev
}

output "subnet_id" {
  description = "Subnets tied to EC2"
  value       = local.subnet_id
}

output "ec2_cluster" {
  description = "Created EC2"
  value       = module.ec2_cluster
}

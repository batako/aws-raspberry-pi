variable "aws_region" {
  type        = string
  description = "AWS region"
}
variable "aws_profile" {
  type        = string
  description = "AWS PROFILE"
}

variable "base_ami_name" {
  type        = string
  description = "Name to search for the base AMI"
}

variable "security_group_name" {
  type        = string
  description = "Security group name"
}

variable "my_cidr_block" {
  type        = string
  description = "Allow CIDR BLOCK when using SSH"
}

variable "route53_zone_name" {
  type        = string
  description = "The base domain name to which the IP is assigned"
}

variable "route53_record_name" {
  type        = string
  description = "The domain name to which the IP is assigned"
}

variable "ec2_name" {
  type        = string
  description = "EC2 Name"
}

variable "key_pair_name" {
  type        = string
  description = "Key Pair Name"
}

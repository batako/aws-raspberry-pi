variable "region" {
  type        = string
  description = "AWS Region"
}

variable "ami_name" {
  type        = string
  description = "EC2 AMI Name"
}

variable "instance_type" {
  type        = string
  description = "EC2 Instance Type"
}

variable "ssh_username" {
  type        = string
  description = "SSH User Name"
}

variable "environment" {
  type        = string
  description = "Name of the tag development environment"
}

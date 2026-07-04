variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "project_name" {
  type    = string
  default = "capstone-phoenix"
}

variable "instance_type" {
  type    = string
  default = "t3.small"
}

variable "ssh_public_key" {
  type = string
}

variable "allowed_ssh_cidr" {
  description = "Your public IP in CIDR notation"
  type        = string
}

variable "worker_count" {
  type    = number
  default = 2
}
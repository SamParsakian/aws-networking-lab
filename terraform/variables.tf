variable "aws_region" {
  description = "AWS region for the whole lab"
  type        = string
  default     = "eu-north-1"
}

variable "availability_zone" {
  description = "Single Availability Zone used by both subnets"
  type        = string
  default     = "eu-north-1a"
}

variable "name_prefix" {
  description = "Prefix used in the Name tag of every resource"
  type        = string
  default     = "sam-aws-networking"
}

variable "vpc_cidr" {
  description = "CIDR range of the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR range of the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR range of the private subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "instance_type" {
  description = "EC2 instance type for both instances"
  type        = string
  default     = "t3.micro"
}

variable "my_ip_cidr" {
  description = "Own public IP in CIDR form (x.x.x.x/32). The only address allowed to reach the public instance over SSH."
  type        = string

  validation {
    condition     = can(cidrnetmask(var.my_ip_cidr)) && var.my_ip_cidr != "0.0.0.0/0"
    error_message = "my_ip_cidr must be a valid CIDR and must not be 0.0.0.0/0."
  }
}

variable "key_name" {
  description = "Name of an existing EC2 key pair for SSH. Null means the instances are launched without a key pair."
  type        = string
  default     = null
}

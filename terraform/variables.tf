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
    condition     = can(cidrnetmask(var.my_ip_cidr)) && endswith(var.my_ip_cidr, "/32")
    error_message = "my_ip_cidr must be a single address in /32 form, for example 203.0.113.10/32."
  }
}

variable "ssh_public_key_path" {
  description = "Path to the local public key that is uploaded to AWS as the EC2 key pair. The private key stays on the local machine."
  type        = string
  default     = "~/.ssh/sam-aws-networking-lab_ed25519.pub"
}

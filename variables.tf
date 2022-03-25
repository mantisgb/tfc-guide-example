variable "region" {
  description = "AWS region"
  default     = "eu-west-2"
}

variable "instance_type" {
  description = "Type of EC2 instance to provision"
  default     = "t2.micro"
}

variable "instance_name" {
  description = "EC2 instance name"
  default     = "Provisioned by Terraform"
}

variable "aws_key" {
  description = "EC2 SSH Key"
  default     = "keith-eu-west2"
}

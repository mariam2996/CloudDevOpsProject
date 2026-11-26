variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
  default     = "CloudDevOpsProject"
}

variable "vpc_id" {
  description = "VPC ID for the Jenkins server"
  type        = string
}

variable "subnet_id" {
  description = "Public subnet ID for the Jenkins server"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI used by Floci EC2"
  type        = string
  default     = "ami-ami-amazonlinux2023"
}

variable "public_key" {
  description = "SSH public key for Jenkins EC2"
  type        = string
}

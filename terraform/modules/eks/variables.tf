variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
  default     = "CloudDevOpsProject"
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for EKS worker nodes"
  type        = list(string)
}

variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "eu-north-1"
}

variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
  default     = "privatebin"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "privatebin_image" {
  description = "PrivateBin S3 Docker image"
  type        = string
  default     = "privatebin/s3:2.0.6"
}

variable "notes_prefix" {
  description = "S3 prefix where PrivateBin notes are stored"
  type        = string
  default     = "notes/"
}

variable "noncurrent_version_expiration_days" {
  description = "Days before old S3 object versions expire"
  type        = number
  default     = 30
}

variable "aws_region" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "privatebin_image" {
  type = string
}

variable "notes_prefix" {
  type = string
}

variable "notes_bucket" {
  type = string
}

variable "notes_bucket_arn" {
  type = string
}

variable "user_data_template" {
  type = string
}

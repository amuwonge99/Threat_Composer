variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "domain_name" {
  description = "Root domain name"
  type        = string
}

variable "subdomain" {
  description = "Subdomain for the app"
  type        = string
}

variable "image_tag" {
  description = "Docker image tag to deploy"
  type        = string
}

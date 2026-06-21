variable "domain_name" {
  description = "Root domain name"
  type        = string
}

variable "subdomain" {
  description = "Subdomain for the app"
  type        = string
}

variable "cloudflare_zone_id" {
  description = "Cloudflare zone ID for DNS validation"
  type        = string
}
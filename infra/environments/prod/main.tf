module "vpc" {
  source      = "../../modules/vpc"
  environment = var.environment
}

module "ecr" {
  source      = "../../modules/ecr"
  environment = var.environment
}

module "acm" {
  source             = "../../modules/acm"
  domain_name        = var.domain_name
  subdomain          = var.subdomain
  cloudflare_zone_id = var.cloudflare_zone_id
}

module "alb" {
  source            = "../../modules/alb"
  environment       = var.environment
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  acm_cert_arn      = module.acm.certificate_arn
}

module "ecs" {
  source             = "../../modules/ecs"
  environment        = var.environment
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  alb_sg_id          = module.alb.alb_sg_id
  target_group_arn   = module.alb.target_group_arn
  ecr_repo_url       = module.ecr.repository_url
  image_tag          = var.image_tag
}

module "dns" {
  source       = "../../modules/dns"
  domain_name  = var.domain_name
  subdomain    = var.subdomain
  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id  = module.alb.alb_zone_id
}

#####
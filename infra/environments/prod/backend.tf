terraform {

  backend "s3" {
    bucket       = "gatus-terraform-state-044260499053"
    key          = "prod/terraform.tfstate"
    region       = "eu-west-2"
    encrypt      = true
    use_lockfile = true
  }
}

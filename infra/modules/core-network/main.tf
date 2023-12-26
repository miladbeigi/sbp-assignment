################################################################################
# VPC Module
################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.4.0"

  name = var.name
  cidr = var.vpc-cidr

  azs                = ["${var.region}a", "${var.region}b"]
  private_subnets    = var.private-subnets-cidr
  public_subnets     = var.public-subnets-cidr
  enable_nat_gateway = var.enbable-nat-gateway
}

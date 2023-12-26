module "network" {
  source               = "./modules/core-network"
  name                 = var.name
  vpc-cidr             = var.vpc-cidr
  region               = var.region
  private-subnets-cidr = var.private-subnets-cidr
  public-subnets-cidr  = var.public-subnets-cidr
  enbable-nat-gateway  = var.enbable-nat-gateway
}

module "terraform-state" {
  source                     = "./modules/terraform-state/"
  env                        = "staging"
  bucket_name                = var.terraform-state-bucket
  dynamodb-prefix-table-name = "app"
}


module "s3-event-sns" {
  source      = "./modules/s3-event-sns"
  bucket-name = var.bucket-name
  topic-name  = var.topic-name
  email       = var.email
}


module "iam-oidc" {
  source      = "./modules/iam-oidc/"
  environment = "staging"

  oidc_provider_url       = "https://token.actions.githubusercontent.com"
  oidc_provider_audiences = ["sts.amazonaws.com"]
  thumbprint_list         = ["6938fd4d98bab03faadb97b34396831e3780aea1", "1c58a3a8518e8759bf075b76b750d4f2df264fcd"]

  app-infra-repos = [

  ]
  core-infra-repos = [
    "miladbeigi/sbp-assignment:*"
  ]

  terraform-state-bucket-name         = module.terraform-state.terraform_state_bucket
  terraform-state-dynamodb-table-name = module.terraform-state.dynamodb_table
}

module "app" {
  source   = "./modules/app"
  ecr_name = var.ecr_name
}

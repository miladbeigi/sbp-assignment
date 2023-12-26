variable "app-infra-repos" { type = list(string) }
variable "core-infra-repos" { type = list(string) }
variable "environment" { type = string }
variable "oidc_provider_url" { type = string }
variable "oidc_provider_audiences" { type = list(string) }
variable "thumbprint_list" { type = list(string) }
variable "terraform-state-bucket-name" { type = string }
variable "terraform-state-dynamodb-table-name" { type = string }

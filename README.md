# Project Documentation

This project is structured into two main directories: `app` and `infra`. The `app` directory contains the source code for the application, while the `infra` directory contains the source code for the infrastructure.

## App

The application is a basic react application that is built using `create-react-app`. The application is deployed to AWS using GitHub Actions and AWS App Runner.

## Infra

The infrastructure is written in Terraform and only the plan and formatting steps are run in GitHub Actions.

### Modules

#### app

This module creates the IAM roles needed for App Runner to get the image from ECR and run the application. It also creates the ECR repository to store the image. This ECR repository is used by GitHub Actions to push the image to.

#### core-network

This module creates the VPC, subnets, internet gateway, NAT gateway, and route tables needed for the application. I am using the `terraform-aws-modules/vpc/aws` module to create the VPC. This is a standard module and creates all needed resources for a VPC. If needed there are many variables that can be used to customize the VPC. But I only used the NAT gateway and subnet variables.

#### iam-oidc

This module creates the IAM OIDC provider needed for GitHub Actions to authenticate with AWS.

#### s3-event-sns

This module creates the S3 bucket and SNS topic needed for the S3 event notification. The SNS topic is used to send a an email when a new object is uploaded to the S3 bucket. Only for demo purposes.

#### terraform-state

This module creates the S3 bucket and DynamoDB table needed to store the Terraform state. Since this requires more step to configure locally, It can be commented out and the default local state can be used.

## GitHub Workflows

### main.yml

This workflow deploys the application to App Runner. It is triggered when a tag is pushed to the repository.

### plan.yml

This workflow runs the Terraform plan and checks the formatting of the Terraform files. It is triggered on a pull request to the main branch.

### deploy.yml

This workflow builds the application, pushes the image to ECR, and deploys the application to App Runner. It is triggered on a tag pushed to the repository. When triggered on a pull request it will only build the docker image to make sure the image can be built.

## Other Files

### cz.toml

This file is used by commitizen to format the commit messages.

# Terraform main configuration for AWS EKS, VPC, IAM, ECR

provider "aws" {
  region = "us-west-1"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  name    = "devops-vpc"
  cidr    = "10.0.0.0/16"
  azs     = ["us-east-1a", "us-east-1b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "devops-eks"
  cluster_version = "1.33"
  subnets         = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id
}

resource "aws_ecr_repository" "app" {
  name = "appointment-app"
}

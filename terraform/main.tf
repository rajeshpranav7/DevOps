# Terraform main configuration for AWS EKS, VPC, IAM, ECR

provider "aws" {
  region = "us-west-1"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  name    = "hcl-vpc"
  cidr    = "10.0.0.0/24"
  azs     = ["us-west-1"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "devops-eks"
  cluster_version = "1.33"
  vpc_id          = module.vpc.vpc_id
}

resource "aws_ecr_repository" "app" {
  name = "devops-eks/appointment-app"
}

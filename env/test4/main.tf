terraform {
  backend "s3" {
  bucket = "terraform-states-prod1"
  key    = "test4/terraform.tfstate"
  region = "us-east-1"

  role_arn = "arn:aws:iam::907143134003:role/TerraformStateAccessRole"
}
}




module "aws_vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.1.0"
  

  name = "my-vpc-south-virginia"
  cidr = "10.0.0.0/16"
  azs            = ["us-east-2a", "us-east-2b", "us-east-2c"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  enable_nat_gateway = true
  single_nat_gateway = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Environment = "test"
    project     = "my-project"
  }

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
  }

}
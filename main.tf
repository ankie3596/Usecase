provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr             = "10.0.0.0/16"
  vpc_name             = "main-vpc"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  availability_zones   = ["us-east-1a", "us-east-1b"]
}

module "security_group" {
  source  = "./modules/security_group"
  vpc_id  = module.vpc.vpc_id
  sg_name = "web-sg"
}

module "asg" {
  source            = "./modules/asg"
  lt_name           = "web-lt"
  asg_name          = "web-asg"
  ami_id            = "ami-0c55b159cbfafe1f0" # Update this
  instance_type     = "t3.micro"
  security_group_id = module.security_group.sg_id
  subnet_ids        = module.vpc.public_subnets
  min_size          = 1
  max_size          = 3
  desired_capacity  = 2
}

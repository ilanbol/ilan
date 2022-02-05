provider "aws" {
  region = "us-east-1"
}


# create eks


module "eks" {
  source       = "git::https://github.com/terraform-aws-modules/terraform-aws-eks.git?ref=v12.1.0"
  cluster_name = "web-cluster"
  vpc_id       = var.vpc
  subnets      = ["subnet-06947a07502cf3616", "subnet-0b398623ae96d66d2", "subnet-06d88bec198a17188"]

  node_groups = {
    eks_nodes = {
      desired_capacity = 3
      max_capacity     = 3
      min_capaicty     = 3

      instance_type = "t2.small"
    }
  }

  manage_aws_auth = false
  write_kubeconfig   = true
  config_output_path = "./"
}
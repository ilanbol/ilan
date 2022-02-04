provider "aws" {
  region = "us-east-1"
}


# create eks


module "eks" {
  source       = "git::https://github.com/terraform-aws-modules/terraform-aws-eks.git?ref=v12.1.0"
  cluster_name = "web-cluster"
  vpc_id       = var.vpc
  subnets      = ["subnet-abcde012", "subnet-bcde012a", "subnet-fghi345a"]

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
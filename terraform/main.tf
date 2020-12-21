locals {
  prefix = terraform.workspace == "prod" ? "modeling" : join("-", ["modeling", terraform.workspace])
}

terraform {
  backend "s3" {
    bucket               = "kavala13-terraform"
    key                  = "terraform.tfstate"
    region               = "us-east-1"
    workspace_key_prefix = "modeling"
  }
}

provider "aws" {
  region = "us-east-1"
}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = var.cloud_backend_bucket
    key    = var.cloud_backend_key
    region = var.cloud_backend_region
  }
}

module "vertica_cluster" {
  source = "github.com/efradelos/terraform-vertica-base"

  vpc_id            = data.terraform_remote_state.vpc.outputs.vpc_id
  public_subnet_id  = data.terraform_remote_state.vpc.outputs.public_subnets[0]
  private_subnet_id = data.terraform_remote_state.vpc.outputs.private_subnets[0]

  # SSH key variables
  create_ssh_key_pair = true
  ssh_key_name        = join("-", [local.prefix, "vertica-ssh-key"])
  ssh_key_path        = var.ssh_key_path

  # Security Group
  create_security_group = true
  security_group_name   = join("-", [local.prefix, "vertica-node-sg"])

  # Communal Storage
  create_communal_storage_bucket = true
  communal_storage_bucket        = "kavala13-vertica"

  # Instance Profile 
  create_instance_profile = true
  instance_profile_name   = join("-", [local.prefix, "vertica-instance-profile"])

  # Management Console
  create_mc        = true
  mc_name          = join("-", [local.prefix, "vertica-mc"])
  mc_ami           = "ami-083bcfe5f5bf588bd"
  mc_instance_type = "c5.large"
  mc_allocation_id = "eipalloc-0b0415df05800faca"
  mc_username      = "mcadmin"
  mc_password      = "change-me"

  # Node variables
  node_count         = 3
  node_prefix        = join("-", [local.prefix, "vertica-node"])
  node_ami           = "ami-083bcfe5f5bf588bd"
  node_instance_type = "c5.large"
  node_volume_size   = 50

  # DB Variables
  db_name     = var.db_name
  dba_user    = var.db_user
  db_password = var.db_password
  db_data_dir = "/vertica/data"

  db_shard_count      = 6
  db_eon_mode         = true
  db_license          = "CE"
  db_depot_path       = "/vertica/data"
  db_communal_storage = "s3://kavala13-vertica/storage"

  # LB Variables
  create_lb        = true
  lb_name          = join("-", [local.prefix, "vertica-nodes-lb"])
  lb_allocation_id = "eipalloc-08820e606aa305367"

  additional_tags = {
    Environment = terraform.workspace
    Team        = "modeling"
    CostCenter  = "modeling-05233"
  }
}

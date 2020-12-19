terraform {
  backend "s3" {
    bucket = "kavala13-terraform"
    key    = "vertica-team-modeling"
    region = "us-east-1"
  }
}

provider "aws" {}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = var.cloud_backend_bucket
    key    = var.cloud_backend_key
    region = var.cloud_backend_region
  }
}

module "vertica_cluster" {
  source = "github.com/efradelos/terraform-vertica-base?ref=v0.1.0"

  vpc_id            = data.terraform_remote_state.vpc.outputs.vpc_id
  public_subnet_id  = data.terraform_remote_state.vpc.outputs.public_subnets[0]
  private_subnet_id = data.terraform_remote_state.vpc.outputs.private_subnets[0]

  # SSH key variables
  create_ssh_key_pair = true
  ssh_key_name        = "vertica-ssh-key"
  ssh_key_path        = "secrets/vertica_key.pub"

  # Security Group
  create_security_group = true
  security_group_name   = "vertica-node-sg"

  # Communal Storage
  create_communal_storage_bucket = true
  communal_storage_bucket        = "kavala13-vertica"

  # Instance Profile 
  create_instance_profile = true
  instance_profile_name   = "vertica-instance-profile"

  # Management Console
  create_mc = true

  # Node variables
  node_count         = 3
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
  db_communal_storage = var.db_communal_storage

  # LB Variables
  create_lb = true


  # # Bastion variables
  # bastion_ami           = "ami-083bcfe5f5bf588bd"
  # bastion_instance_type = "c5.large"
  # bastion_allocation_id = "eipalloc-0a4ef025603e58f23"

}

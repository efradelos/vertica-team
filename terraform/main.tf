data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = var.cloud_backend_bucket
    key    = var.cloud_backend_key
    region = var.cloud_backend_region
  }
}

module "vertica_cluster" {
  source = "git::https://github.com/efradelos/terraform-vertica-base.git"

  aws_access_key = var.aws_access_key
  aws_secret_key = var.aws_secret_key
  aws_region     = var.aws_region

  vpc_id            = data.terraform_remote_state.vpc.outputs.vpc_id
  public_subnet_id  = data.terraform_remote_state.vpc.outputs.public_subnets[0]
  private_subnet_id = data.terraform_remote_state.vpc.outputs.private_subnets[0]

  node_count = 3

  db_name     = var.db_name
  dba_user    = var.db_user
  db_password = var.db_password
  db_data_dir = "/vertica/data"

  db_shard_count      = 6
  db_eon_mode         = true
  db_license          = "CE"
  db_depot_path       = "/vertica/data"
  db_communal_storage = var.db_communal_storage

  # SSH key variables
  create_ssh_key_pair = false
  ssh_key_name        = "vertica-ssh-key"
  ssh_key_path        = "secrets/key"

  # Node variables
  node_ami           = "ami-083bcfe5f5bf588bd"
  node_instance_type = "c5.large"
  node_volume_size   = 50


  # Bastion variables
  bastion_ami           = "ami-083bcfe5f5bf588bd"
  bastion_instance_type = "c5.large"
  bastion_allocation_id = "eipalloc-0a4ef025603e58f23"

  install_key         = "secrets/install.pub"
  private_install_key = "secrets/install"

  create_lb = true
}

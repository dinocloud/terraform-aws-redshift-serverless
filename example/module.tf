module "this" {
  source = "git::https://github.com/dinocloud/terraform-aws-redshift-serverless.git"

  cluster_name                  = "dinocloud-examples"
  admin_username                = "dinocloud_admin"
  admin_user_password           = "UltraAwesomePassword123!"
  db_name                       = "dinocloud"
  create_default_security_group = true
  workgroup_subnet_ids          = ["subnet-12345678", "subnet-87654321"]
}

variable "cluster_name" {
  description = "The name of the Amazon Redshift namespace"
  type        = string
  default     = null
}

variable "admin_username" {
  description = "The name of the master user for the Amazon Redshift namespace"
  type        = string
  default     = null
}

variable "admin_user_password" {
  description = "The password of the master user for the Amazon Redshift namespace"
  type        = string
  default     = null
}

variable "db_name" {
  description = "The name of the first Amazon Redshift database"
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "kms_key_id" {
  description = "The ARN for the KMS key that will be used to encrypt the data in the cluster"
  type        = string
  default     = null
}

variable "create_default_iam_role" {
  description = "Whether to create the default IAM role"
  type        = bool
  default     = false
}

variable "default_iam_role_name" {
  description = "The name of the default IAM role"
  type        = string
  default     = null
}

variable "iam_roles" {
  description = "A list of IAM roles ARNs to associate with the Amazon Redshift namespace"
  type        = list(string)
  default     = []
}


variable "rpu_base_capacity" {
  description = "The minimum number of compute nodes that the Amazon Redshift serverless cluster can use"
  type        = number
  default     = 8
}

variable "rpu_max_capacity" {
  description = "The maximum number of compute nodes that the Amazon Redshift serverless cluster can use"
  type        = number
  default     = 16
}

variable "workgroup_port" {
  description = "The port number on which the Amazon Redshift serverless cluster accepts incoming connections"
  type        = number
  default     = 5439
}

variable "publicly_accessible" {
  description = "Whether the Amazon Redshift serverless cluster is publicly accessible"
  type        = bool
  default     = false
}

variable "workgroup_subnet_ids" {
  description = "A list of subnet IDs in the Amazon Redshift serverless cluster VPC"
  type        = list(string)
  default     = []
}

variable "security_group_ids" {
  description = "A list of security group IDs in the Amazon Redshift serverless cluster VPC"
  type        = list(string)
  default     = []
}

variable "create_default_security_group" {
  description = "Whether to create the default security group"
  type        = bool
  default     = true
}

# TODO: Create Zero-ETL integrations

# variable "zero_etl_integrations" {
#   description = "A list of the RDS cluster names for which to create zero ETL integrations"
#   type        = list(string)
#   default     = []
# }

# data "aws_rds_cluster" "this" {
#   for_each = toset(var.zero_etl_integrations)

#   cluster_identifier = each.key
# }

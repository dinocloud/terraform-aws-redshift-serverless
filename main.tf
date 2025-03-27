resource "aws_redshiftserverless_namespace" "this" {
  for_each = toset([var.cluster_name])

  namespace_name      = var.cluster_name
  admin_username      = var.admin_username
  admin_user_password = var.admin_user_password
  db_name             = var.db_name
  kms_key_id          = var.kms_key_id

  iam_roles = var.iam_roles

  tags = var.tags
}

resource "aws_redshiftserverless_workgroup" "this" {
  for_each = toset([var.cluster_name])

  namespace_name      = aws_redshiftserverless_namespace.this[var.cluster_name].namespace_name
  workgroup_name      = var.cluster_name
  base_capacity       = var.rpu_base_capacity
  max_capacity        = var.rpu_max_capacity
  port                = var.workgroup_port
  publicly_accessible = var.publicly_accessible
  subnet_ids          = var.workgroup_subnet_ids

  security_group_ids = compact(flatten([
    var.security_group_ids,
    var.create_default_security_group && length(var.workgroup_subnet_ids) > 0 ? [aws_security_group.this[var.cluster_name].id] : [],
  ]))

  tags = var.tags
}

# TODO: Create Zero-ETL integrations

# resource "aws_rds_integration" "this" {
#   for_each = toset(var.zero_etl_integrations)

#   integration_name = "${each.key}-to-${var.cluster_name}"
#   source_arn       = data.aws_rds_cluster.this[each.key].cluster_arn
#   target_arn       = aws_redshiftserverless_namespace.this[each.key].namespace_arn

#   tags = var.tags
# }

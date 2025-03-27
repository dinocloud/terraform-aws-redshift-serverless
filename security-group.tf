# Creates default security group for Redshift Serverless cluster
# if var.create_default_security_group is true (default is true)

data "aws_subnet" "this" {
  count = length(var.workgroup_subnet_ids) > 0 ? 1 : 0
  id    = var.workgroup_subnet_ids[0]
}

data "aws_vpc" "this" {
  count = length(data.aws_subnet.this) > 0 ? 1 : 0
  id    = length(data.aws_subnet.this) > 0 ? data.aws_subnet.this[0].vpc_id : null
}

resource "aws_security_group" "this" {
  for_each = var.create_default_security_group && length(var.workgroup_subnet_ids) > 0 ? toset([var.cluster_name]) : []

  name   = "${var.cluster_name}-redshiftserverless"
  vpc_id = length(data.aws_vpc.this) > 0 ? data.aws_vpc.this[0].id : null

  ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [length(data.aws_vpc.this) > 0 ? data.aws_vpc.this[0].cidr_block : null]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.cluster_name}-redshiftserverless"
  })
}

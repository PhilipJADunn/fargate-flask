##########################################################################################
### VPC module from terraform
##########################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.0"

  name = "fargate-flask-vpc"

  azs             = local.azs
  cidr            = var.vpc_cidr
  private_subnets = local.private_subnets
  public_subnets  = local.public_subnets

  enable_dns_hostnames    = true
  enable_dns_support      = true
  enable_nat_gateway      = false
  single_nat_gateway      = false
  one_nat_gateway_per_az  = false
  instance_tenancy        = "default"
  create_igw              = true
  map_public_ip_on_launch = false

  enable_flow_log                                 = true
  flow_log_destination_type                       = "cloud-watch-logs"
  flow_log_cloudwatch_iam_role_arn                = aws_iam_role.flow_logs_role.arn
  create_flow_log_cloudwatch_log_group            = true
  flow_log_cloudwatch_log_group_name_suffix       = "fargate-flask/${data.aws_region.current.name}"
  flow_log_cloudwatch_log_group_retention_in_days = var.flow_log_retention_in_days
  flow_log_traffic_type                           = var.flow_log_traffic_type

  default_route_table_routes = [{ "cidr_block" : "0.0.0.0/0" }]

  manage_default_network_acl  = true
  default_network_acl_name    = "fargate-flask-nacl-default"
  default_network_acl_ingress = []
  default_network_acl_egress  = []

  public_dedicated_network_acl = true
  public_inbound_acl_rules     = local.public_inbound_acl_rules
  public_outbound_acl_rules    = local.public_outbound_acl_rules

  private_dedicated_network_acl = true
  private_inbound_acl_rules     = local.private_inbound_acl_rules
  private_outbound_acl_rules    = local.private_outbound_acl_rules

  manage_default_security_group  = true
  default_security_group_name    = "$fargate-flask-sg-default"
  default_security_group_ingress = []
  default_security_group_egress  = []

  tags = var.tags
}
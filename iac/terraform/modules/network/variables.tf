variable "vpc_cidr" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "flow_log_retention_in_days" {
  type        = number
  description = "Specifies the number of days you want to retain log events"
  default     = "365"
}

variable "flow_log_traffic_type" {
  type        = string
  description = "The type of traffic to log"
  default     = "ALL"
}

variable "legacy_partition" {
  type    = bool
  default = false
}

locals {
  partition       = var.legacy_partition == true ? cidrsubnets(var.vpc_cidr, 2, 2, 2) : cidrsubnets(var.vpc_cidr, 1, 1)
  private_subnets = cidrsubnets(local.partition[0], 2, 2, 2)
  public_subnets  = var.legacy_partition == true ? cidrsubnets(local.partition[1], 3, 3, 3) : cidrsubnets(local.partition[1], 2, 2, 2)
  azs             = formatlist("${data.aws_region.current.name}%s", ["a", "b", "c"])
}


locals {
  public_inbound_acl_rules = [
    {
      rule_number = 10010
      egress      = false
      protocol    = "tcp"
      rule_action = "allow"
      cidr_block  = "0.0.0.0/0"
      from_port   = 80
      to_port     = 80
    },
    {
      rule_number = 10020
      egress      = false
      protocol    = "tcp"
      rule_action = "allow"
      cidr_block  = "0.0.0.0/0"
      from_port   = 443
      to_port     = 443
    },
    {
      rule_number = 10901
      egress      = false
      protocol    = "tcp"
      rule_action = "deny"
      cidr_block  = "0.0.0.0/0"
      from_port   = 22
      to_port     = 22
    },
    {
      rule_number = 10902
      egress      = false
      protocol    = "tcp"
      rule_action = "deny"
      cidr_block  = "0.0.0.0/0"
      from_port   = 3389
      to_port     = 3389
    },
    # Allow ephemeral ports from internet
    {
      rule_number = 11000
      egress      = false
      protocol    = "tcp"
      rule_action = "allow"
      cidr_block  = "0.0.0.0/0"
      from_port   = 1024
      to_port     = 65535
    }
  ]
  public_outbound_acl_rules = [
    {
      rule_number = 10000
      egress      = true
      protocol    = "tcp"
      rule_action = "allow"
      cidr_block  = "0.0.0.0/0"
      from_port   = 1024
      to_port     = 65535
    },
    {
      rule_number = 10010
      egress      = true
      protocol    = "tcp"
      rule_action = "allow"
      cidr_block  = "0.0.0.0/0"
      from_port   = 80
      to_port     = 80
    },
    {
      rule_number = 10020
      egress      = true
      protocol    = "tcp"
      rule_action = "allow"
      cidr_block  = "0.0.0.0/0"
      from_port   = 443
      to_port     = 443
    }
  ]
  private_inbound_acl_rules = [
    {
      rule_number = 10000
      egress      = false
      protocol    = "tcp"
      rule_action = "allow"
      cidr_block  = var.vpc_cidr
      from_port   = 1024
      to_port     = 65535
    },
    {
      rule_number = 10010
      egress      = false
      protocol    = "tcp"
      rule_action = "allow"
      cidr_block  = var.vpc_cidr
      from_port   = 80
      to_port     = 80
    },
    {
      rule_number = 10020
      egress      = false
      protocol    = "tcp"
      rule_action = "allow"
      cidr_block  = var.vpc_cidr
      from_port   = 443
      to_port     = 443
    },
    {
      rule_number = 10901
      egress      = false
      protocol    = "tcp"
      rule_action = "deny"
      cidr_block  = "0.0.0.0/0"
      from_port   = 22
      to_port     = 22
    },
    {
      rule_number = 10902
      egress      = false
      protocol    = "tcp"
      rule_action = "deny"
      cidr_block  = "0.0.0.0/0"
      from_port   = 3389
      to_port     = 3389
    },
    {
      rule_number = 15000
      egress      = false
      protocol    = "6"
      rule_action = "allow"
      cidr_block  = "0.0.0.0/0"
      from_port   = 1024
      to_port     = 65535
    }

  ]
  private_outbound_acl_rules = [
    {
      rule_number = 10000
      egress      = true
      protocol    = "all"
      rule_action = "allow"
      cidr_block  = "0.0.0.0/0"
    },
    {
      rule_number = 10010
      egress      = true
      protocol    = "6"
      rule_action = "allow"
      cidr_block  = "0.0.0.0/0"
      from_port   = 443
      to_port     = 443
    },
    {
      rule_number = 11000
      egress      = true
      protocol    = "tcp"
      rule_action = "allow"
      cidr_block  = var.vpc_cidr
      from_port   = 1024
      to_port     = 65535
    }
  ]
}
variable "identifier" {
  type    = string
  default = "flask"
}
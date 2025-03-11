<!-- BEGIN_TF_DOCS -->
# fargate-flask-network

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0.0, < 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0.0, < 5.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 3.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.flow_logs_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.vpc_flow_logs_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | n/a | `string` | n/a | yes |
| <a name="input_flow_log_retention_in_days"></a> [flow\_log\_retention\_in\_days](#input\_flow\_log\_retention\_in\_days) | Specifies the number of days you want to retain log events | `number` | `"365"` | no |
| <a name="input_flow_log_traffic_type"></a> [flow\_log\_traffic\_type](#input\_flow\_log\_traffic\_type) | The type of traffic to log | `string` | `"ALL"` | no |
| <a name="input_identifier"></a> [identifier](#input\_identifier) | n/a | `string` | `"flask"` | no |
| <a name="input_legacy_partition"></a> [legacy\_partition](#input\_legacy\_partition) | n/a | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_Output_InternetGatewayID"></a> [Output\_InternetGatewayID](#output\_Output\_InternetGatewayID) | The VPCs Internet Gateway ID |
| <a name="output_Output_PrivateSubnet1Id"></a> [Output\_PrivateSubnet1Id](#output\_Output\_PrivateSubnet1Id) | Private subnet1 id |
| <a name="output_Output_PrivateSubnet2Id"></a> [Output\_PrivateSubnet2Id](#output\_Output\_PrivateSubnet2Id) | Private subnet2 id |
| <a name="output_Output_PrivateSubnet3Id"></a> [Output\_PrivateSubnet3Id](#output\_Output\_PrivateSubnet3Id) | Private subnet3 id |
| <a name="output_Output_PrivateSubnets"></a> [Output\_PrivateSubnets](#output\_Output\_PrivateSubnets) | Private subnet IDs |
| <a name="output_Output_PublicSubnet1Id"></a> [Output\_PublicSubnet1Id](#output\_Output\_PublicSubnet1Id) | Public subnet1 id |
| <a name="output_Output_PublicSubnet2Id"></a> [Output\_PublicSubnet2Id](#output\_Output\_PublicSubnet2Id) | Public subnet2 id |
| <a name="output_Output_PublicSubnet3Id"></a> [Output\_PublicSubnet3Id](#output\_Output\_PublicSubnet3Id) | Public subnet3 id |
| <a name="output_Output_PublicSubnets"></a> [Output\_PublicSubnets](#output\_Output\_PublicSubnets) | Public subnet IDs |
| <a name="output_Output_VpcCIDR"></a> [Output\_VpcCIDR](#output\_Output\_VpcCIDR) | The VPC CIDR |
| <a name="output_VpcId"></a> [VpcId](#output\_VpcId) | The VPC ID |
<!-- END_TF_DOCS -->
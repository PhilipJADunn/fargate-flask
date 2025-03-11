
output "VpcId" {
  description = "The VPC ID"
  value       = module.vpc.vpc_id
}
output "Output_VpcCIDR" {
  description = "The VPC CIDR"
  value       = module.vpc.vpc_cidr_block
  sensitive   = true
}
output "Output_PrivateSubnet1Id" {
  description = "Private subnet1 id"
  value       = module.vpc.private_subnets[0]
}
output "Output_PrivateSubnet2Id" {
  description = "Private subnet2 id"
  value       = module.vpc.private_subnets[1]
}
output "Output_PrivateSubnet3Id" {
  description = "Private subnet3 id"
  value       = module.vpc.private_subnets[2]
}
output "Output_PublicSubnet1Id" {
  description = "Public subnet1 id"
  value       = module.vpc.public_subnets[0]
}
output "Output_PublicSubnet2Id" {
  description = "Public subnet2 id"
  value       = module.vpc.public_subnets[1]
}
output "Output_PublicSubnet3Id" {
  description = "Public subnet3 id"
  value       = module.vpc.public_subnets[2]
}
output "Output_InternetGatewayID" {
  description = "The VPCs Internet Gateway ID"
  value       = module.vpc.igw_id
}

output "Output_PublicSubnets" {
  description = "Public subnet IDs"
  value       = [for id in module.vpc.public_subnets : id]
}
output "Output_PrivateSubnets" {
  description = "Private subnet IDs"
  value       = [for id in module.vpc.private_subnets : id]
}
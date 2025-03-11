
output "VpcId" {
  description = "The VPC ID"
  value       = module.vpc.VpcId
}
output "Output_VpcCIDR" {
  description = "The VPC CIDR"
  value       = module.vpc.Output_VpcCIDR
  sensitive   = true
}
output "Output_PrivateSubnet1Id" {
  description = "Private subnet1 id"
  value       = module.vpc.Output_PrivateSubnet1Id
}
output "Output_PrivateSubnet2Id" {
  description = "Private subnet2 id"
  value       = module.vpc.Output_PrivateSubnet2Id
}
output "Output_PrivateSubnet3Id" {
  description = "Private subnet3 id"
  value       = module.vpc.Output_PrivateSubnet3Id
}
output "Output_PublicSubnet1Id" {
  description = "Public subnet1 id"
  value       = module.vpc.Output_PublicSubnet1Id
}
output "Output_PublicSubnet2Id" {
  description = "Public subnet2 id"
  value       = module.vpc.Output_PublicSubnet2Id
}
output "Output_PublicSubnet3Id" {
  description = "Public subnet3 id"
  value       = module.vpc.Output_PublicSubnet3Id
}
output "Output_InternetGatewayID" {
  description = "The VPCs Internet Gateway ID"
  value       = module.vpc.Output_InternetGatewayID
}
output "Output_PublicSubnets" {
  description = "The VPCs Public"
  value       = module.vpc.Output_PublicSubnets
}

output "Output_PrivateSubnets" {
  description = "The VPCs Private"
  value       = module.vpc
}
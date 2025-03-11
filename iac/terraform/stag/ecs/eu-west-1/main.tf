module "ecs" {
  source               = "../../../modules/ecs"
  vpc_id               = var.vpc_id
  flask_private_subnet = var.flask_private_subnet
  flask_public_subnet  = var.flask_public_subnet
  environment          = var.environment
  tags                 = local.tags
}
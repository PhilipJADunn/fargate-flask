resource "aws_ecs_cluster" "ecs_cluster" {
  name = "flask-ecs-cluster"
}

resource "aws_ecs_service" "ecs_service" {
  name                = "my-ecs-service"
  cluster             = aws_ecs_cluster.ecs_cluster.id
  task_definition     = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count       = 2
  launch_type         = "FARGATE"
  scheduling_strategy = "REPLICA"

  network_configuration {
    subnets          = var.flask_public_subnet
    security_groups  = [aws_security_group.ecs_tasks.id]
    assign_public_ip = true
  }


  load_balancer {
    target_group_arn = aws_lb_target_group.fargate-tg.arn
    container_name   = "flask-app"
    container_port   = 5000
  }
  lifecycle {
    ignore_changes = [task_definition, desired_count]
  }
  tags = var.tags
}

resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                   = "flask-ecs-task"
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  cpu                      = 256
  memory                   = 512
  requires_compatibilities = ["FARGATE"]
  container_definitions = jsonencode([
    {
      name      = "flask-app"
      image     = "${data.aws_caller_identity.current.account_id}.dkr.ecr.eu-west-1.amazonaws.com/philips-fargate:latest"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 5000
          protocol      = "tcp"
        }
      ]
    }
  ])
}
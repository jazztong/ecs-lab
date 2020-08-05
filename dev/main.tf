provider "aws" {
  region = "ap-southeast-1"
  assume_role {
    role_arn = "arn:aws:iam::986060684878:role/Admin_Role"
  }
}

resource "aws_ecs_cluster" "this" {
  name = "my-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_service" "web" {
  name        = "web"
  cluster     = aws_ecs_cluster.this.id
  launch_type = "FARGATE"

  load_balancer {
    target_group_arn = aws_lb_target_group.nginx.arn
    container_name   = "nginx"
    container_port   = 80
  }

  task_definition = aws_ecs_task_definition.nginx.arn
  desired_count   = 2
  network_configuration {
    subnets          = data.aws_subnet_ids.this.ids
    security_groups  = [aws_security_group.allow_http.id]
    assign_public_ip = true
  }
}

resource "aws_ecs_task_definition" "nginx" {
  family                   = "nginx"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.task_execute.arn
  container_definitions = jsonencode(
    [
      {
        "name" : "nginx",
        "essential" : true,
        "image" : "nginx:latest",
        "portMappings" : [
          {
            "containerPort" : 80,
            "hostPort" : 80
          }
        ]
      }
  ])
}

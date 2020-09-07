
resource "aws_ecs_service" "web" {
  name        = "web"
  cluster     = aws_ecs_cluster.this.id
  launch_type = "FARGATE"

  load_balancer {
    target_group_arn = aws_lb_target_group.api.arn
    container_name   = "nginx"
    container_port   = 5000
    # container_port   = 80
  }

  task_definition = aws_ecs_task_definition.nginx.arn
  desired_count   = 1
  network_configuration {
    subnets          = data.aws_subnet_ids.this.ids
    security_groups  = [aws_security_group.allow_http.id]
    assign_public_ip = true
  }

  service_registries {
    registry_arn = aws_service_discovery_service.nginx.arn
  }

  depends_on = [aws_lb.this]
}

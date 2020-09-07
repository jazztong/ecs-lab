resource "aws_appautoscaling_target" "nginx_target" {
  max_capacity       = 10
  min_capacity       = 1
  resource_id        = "service/${aws_ecs_cluster.this.name}/${aws_ecs_service.web.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "nginx_cpu_scale_policy" {
  name               = "nginx_cpu_policy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.nginx_target.resource_id
  scalable_dimension = aws_appautoscaling_target.nginx_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.nginx_target.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = 60

    scale_in_cooldown  = 60
    scale_out_cooldown = 60

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
  }

  depends_on = [aws_appautoscaling_target.nginx_target]
}

resource "aws_appautoscaling_policy" "nginx_mem_scale_policy" {
  name               = "nginx_mem_policy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.nginx_target.resource_id
  scalable_dimension = aws_appautoscaling_target.nginx_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.nginx_target.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = 60

    scale_in_cooldown  = 300
    scale_out_cooldown = 300

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
  }

  depends_on = [aws_appautoscaling_target.nginx_target]
}

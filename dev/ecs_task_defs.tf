resource "aws_ecs_task_definition" "nginx" {
  family                   = "nginx"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  task_role_arn            = aws_iam_role.task_execute.arn
  execution_role_arn       = aws_iam_role.task_execute.arn
  container_definitions = jsonencode(
    [
      {
        "name" : "nginx",
        "essential" : true,
        "image" : "210636571704.dkr.ecr.ap-southeast-1.amazonaws.com/test/core-api:v0.0.2",
        "portMappings" : [
          {
            "containerPort" : 5000,
            "hostPort" : 5000
          }
        ],
        "logConfiguration" : {
          "logDriver" : "awslogs",
          "secretOptions" : null,
          "options" : {
            "awslogs-group" : "/ecs/api",
            "awslogs-region" : "ap-southeast-1",
            "awslogs-stream-prefix" : "ecs"
          }
        },
      }
  ])
}

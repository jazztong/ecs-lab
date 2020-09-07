
locals {
  taskRole_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"]
}

resource "aws_iam_role_policy_attachment" "task_execute" {
  count = length(local.taskRole_policy_arns)

  role       = aws_iam_role.task_execute.name
  policy_arn = element(local.taskRole_policy_arns, count.index)
}

resource "aws_iam_role" "task_execute" {
  name = "ecsTaskRole"
  path = "/"

  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : "sts:AssumeRole",
          "Principal" : {
            "Service" : "ecs-tasks.amazonaws.com"
          },
          "Effect" : "Allow",
          "Sid" : ""
        }
      ]
    }
  )
}

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

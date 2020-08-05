data "aws_subnet_ids" "this" {
  vpc_id = data.aws_vpc.this.id
}

data "aws_vpc" "this" {
  default = true
}

data "aws_caller_identity" "current" {}

data "aws_elb_service_account" "main" {}

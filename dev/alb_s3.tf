locals {
  bucket_name = "alb-logs-bucket-mylogs"
}

resource "aws_s3_bucket" "lb_logs" {
  bucket        = local.bucket_name
  acl           = "private"
  force_destroy = true
}

resource "aws_s3_bucket_policy" "lb_logspolicy" {
  bucket = aws_s3_bucket.lb_logs.id

  policy = jsonencode(
    {
      "Id" : "Policy",
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : [
            "s3:PutObject"
          ],
          "Effect" : "Allow",
          "Resource" : "arn:aws:s3:::${local.bucket_name}/AWSLogs/*",
          "Principal" : {
            "AWS" : [
              "${data.aws_elb_service_account.main.arn}"
            ]
          }
        }
      ]
    }
  )

}

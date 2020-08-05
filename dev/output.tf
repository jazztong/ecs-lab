output "address" {
  value = {
    lb_dns = aws_lb.this.dns_name
  }
}

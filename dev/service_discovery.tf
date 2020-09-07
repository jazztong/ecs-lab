resource "aws_service_discovery_private_dns_namespace" "this" {
  name = "testing.local"
  vpc  = data.aws_vpc.this.id
}

resource "aws_service_discovery_service" "nginx" {
  name = "nginx"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.this.id

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}

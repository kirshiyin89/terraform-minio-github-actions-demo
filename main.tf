terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }
  }
}

resource "local_file" "high_risk_file" {
  filename = "secrets.txt"
  content = <<-EOF
  # DELIBERATE SECURITY RISKS
  ADMIN_PASSWORD = "password123"
  SECRET_KEY = "sk-very-dangerous-key"
  DATABASE_CONNECTION = "postgres://admin:superunsafepassword@localhost"
  EOF
  file_permission = "0666"  # Extremely permissive
}

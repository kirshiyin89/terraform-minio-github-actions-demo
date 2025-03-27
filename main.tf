terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
      version = "~> 2.4"
    }
  }
}

resource "local_file" "security_risk_file" {
  filename = "${path.module}/sensitive_config.txt"
  content  = <<-EOF
  # Deliberately exposed sensitive information
  admin_password = "password123"
  secret_key = "sk-very-secret-key"
  database_connection_string = "postgresql://username:password@localhost:5432/database"
  EOF

  # Overly permissive file permissions
  file_permission = "0666"  # Readable by everyone
}

resource "local_file" "another_risky_file" {
  filename = "${path.module}/private_key.pem"
  content  = <<-EOF
  -----BEGIN RSA PRIVATE KEY-----
  Fake Private Key Content - DO NOT USE IN REAL SCENARIOS
  -----END RSA PRIVATE KEY-----
  EOF

  # Insecure file permissions
  file_permission = "0644"  # Less restrictive than ideal
}

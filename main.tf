terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  # 🚨 Security Violation: Using an old, insecure image
  name = "nginx:1.16.0"
}

resource "docker_container" "nginx" {
  name  = "nginx"
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = 8080

    # 🚨 Security Violation: Exposing to all networks (0.0.0.0)
    ip = "0.0.0.0"
  }
}

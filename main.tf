terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "vulnerable_nginx" {
  name = "nginx:1.16.0"  # Deliberately using an old, vulnerable image
  keep_locally = false
}

resource "docker_container" "insecure_container" {
  name  = "insecure-nginx"
  image = docker_image.vulnerable_nginx.image_id

  ports {
    internal = 80
    external = 8080
    # Security risk: exposing to all interfaces
    ip = "0.0.0.0"
  }

  # Intentional security misconfigurations
  privileged = true  # Extremely risky - gives full host access
}

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
  # Security Violation 1: Using an outdated and potentially vulnerable image
  name = "nginx:1.16.0"  
  keep_locally = false
}

resource "docker_container" "nginx" {
  name  = "nginx-container"
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = 8080
    # Security Violation 2: Exposing port to all interfaces (0.0.0.0)
    ip = "0.0.0.0"
  }

  # Security Violation 3: No resource limits
  resources {
    # Missing CPU and memory limits
  }
}

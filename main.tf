terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "vulnerable_image" {
  name = "nginx:1.16.0"  # Old, potentially vulnerable image
}

resource "docker_container" "insecure_container" {
  name  = "example-container"
  image = docker_image.vulnerable_image.image_id

  ports {
    internal = 80
    external = 8080
    ip       = "0.0.0.0"  # Exposed to all interfaces
  }
}

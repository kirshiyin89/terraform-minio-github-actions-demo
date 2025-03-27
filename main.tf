terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

resource "docker_container" "minio" {
  name  = "minio"
  image = "minio/minio"
  ports {
    internal = 9000
    external = 9000
  }
  env = [
     "MINIO_ROOT_USER=admin",
     "MINIO_ROOT_PASSWORD=supersecret"
  ]
  command = ["server", "/data"]
}

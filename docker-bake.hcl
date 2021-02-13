target "ghaction-docker-meta" {}

target "build" {
  inherits = ["ghaction-docker-meta"]
  context = "./"
  dockerfile = "Dockerfile"
}

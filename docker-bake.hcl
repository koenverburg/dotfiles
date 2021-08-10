target "ghaction-docker-meta" {}

target "helios" {
  inherits = ["ghaction-docker-meta"]
  context = "./"
  dockerfile = "helios.dockerfile"
  tags = [
    "ghcr.io/koenverburg/dotfiles/helios"
  ]
}

target "mars" {
  inherits = ["ghaction-docker-meta"]
  context = "./"
  dockerfile = "ubuntu.dockerfile"
  tags = [
    "ghcr.io/koenverburg/dotfiles/mars-ubuntu"
  ]
}

target "ghaction-docker-meta" {}

target "ubuntu" {
  inherits = ["ghaction-docker-meta"]
  context = "./"
  dockerfile = "ubuntu.dockerfile"
  tags = [
    "ghcr.io/koenverburg/dotfiles/ubuntu"
  ]
}

target "helios" {
  inherits = ["ghaction-docker-meta"]
  context = "./"
  dockerfile = "helios.dockerfile"
  tags = [
    "ghcr.io/koenverburg/dotfiles/helios"
  ]
}

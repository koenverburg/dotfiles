target "ghaction-docker-meta" {}

target "helios" {
  inherits = ["ghaction-docker-meta"]
  context = "./"
  dockerfile = "helios.dockerfile"
  tags = [
    "ghcr.io/koenverburg/dotfiles/helios"
  ]
}

# Ra is the god of the sun in Egypt
target "ra" {
  inherits = ["ghaction-docker-meta"]
  context = "./"
  dockerfile = "ubuntu.dockerfile"
  tags = [
    "ghcr.io/koenverburg/dotfiles/ra-ubuntu"
  ]
}

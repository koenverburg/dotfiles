target "ghaction-docker-meta" {}

target "ubuntu" {
  inherits = ["ghaction-docker-meta"]
  context = "./"
  dockerfile = "ubuntu.dockerfile"
  tags = [
    "ghcr.io/koenverburg/dotfiles/workspace-ubuntu"
  ]
}


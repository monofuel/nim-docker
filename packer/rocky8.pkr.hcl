packer {
  required_plugins {
    docker = {
      version = ">= 0.0.7"
      source  = "github.com/hashicorp/docker"
    }
  }
}

source "docker" "rockylinux" {
    image  = "rockylinux:8"
    commit = true
}

build {
    name = "dev-builder"
    sources = [
        "source.docker.rockylinux"
    ]
    provisioner "ansible" {
      playbook_file = "../../playbooks/build-nim.yml"
      groups = ["nim"]
    }

    post-processor "docker-tag" {
        repository = "monofuel/nim"
        tags       = ["latest", "rocky8", "rocky"]
        only       = ["docker.rockylinux"]
    }
}

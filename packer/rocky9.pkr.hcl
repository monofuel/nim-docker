packer {
  required_plugins {
    docker = {
      version = ">= 1.0.1"
      source  = "github.com/hashicorp/docker"
    }
  }
}

source "docker" "rockylinux" {
    image  = "rockylinux:9"
    commit = true
}

build {
    name = "dev-builder"
    sources = [
        "source.docker.rockylinux"
    ]
    provisioner "ansible" {
      playbook_file = "playbooks/build-nim.yml"
      groups = ["nim"]
      ansible_env_vars = [
        "ANSIBLE_SSH_ARGS='-oHostKeyAlgorithms=+ssh-rsa -oPubkeyAcceptedKeyTypes=ssh-rsa'",
        "ANSIBLE_HOST_KEY_CHECKING=False"
      ]
    }

    post-processor "docker-tag" {
        repository = "monofuel/nim"
        tags       = ["latest", "rocky9", "rocky"]
        only       = ["docker.rockylinux"]
    }
}

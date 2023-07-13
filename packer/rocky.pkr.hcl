packer {
  required_plugins {
    docker = {
      version = ">= 1.0.1"
      source  = "github.com/hashicorp/docker"
    }
  }
}

source "docker" "rockylinux8-amd64" {
    image  = "rockylinux:8"
    commit = true
    platform = "linux/amd64"
}


source "docker" "rockylinux9-amd64" {
    image  = "rockylinux:9"
    commit = true
    platform = "linux/amd64"

}

source "docker" "rockylinux9-arm64" {
    image  = "rockylinux:9"
    commit = true
    platform = "linux/arm64"
}

build {
    name = "dev-builder"
    sources = [
        "source.docker.rockylinux8-amd64",
        "source.docker.rockylinux9-amd64",
        "source.docker.rockylinux9-arm64"
    ]
    provisioner "ansible" {
      playbook_file = "playbooks/build-nim.yml"
      groups = ["nim"]
      ansible_env_vars = [
        "ANSIBLE_SSH_ARGS='-oHostKeyAlgorithms=+ssh-rsa -oPubkeyAcceptedKeyTypes=ssh-rsa'",
        "ANSIBLE_HOST_KEY_CHECKING=False"
      ]
    }

    # TODO how to add /root/.nimble/bin to path?
    # TODO how to efficiently make manifests?
    post-processor "docker-tag" {
        repository = "monofuel/nim"
        tags       = ["rocky9-amd64"]
        only       = [
          "docker.rockylinux9-amd64"
        ]
    }
    
    post-processor "docker-tag" {
        repository = "monofuel/nim"
        tags       = ["rocky8-amd64"]
        only       = ["docker.rockylinux8-amd64"]
    }
    post-processor "manifest" {
      output = "manifest.json
    }
}


# .PHONY: build-amd64
# build-amd64:
# 	docker build --no-cache -t monofuel/nim:amd64 .
# 	docker push monofuel/nim:amd64

# .PHONY: build-arm32v6
# build-arm32v6:
# 	docker build --no-cache -t monofuel/nim:arm32v6 .
# 	docker push monofuel/nim:arm32v6

# .PHONY: manifest
# manifest:
# 	docker manifest create --amend monofuel/nim:latest monofuel/nim:amd64 monofuel/nim:arm32v6
# 	docker manifest push monofuel/nim:latest

.PHONY: pull
pull: pull-alpine pull-rocky8 pull-rocky9 pull-ubuntu20 pull-ubuntu22

.PHONY: pull-alpine
pull-alpine:
	docker pull registry.gitlab.com/mono-homelab/nim-docker:alpine

.PHONY: pull-rocky8
pull-rocky8:
	docker pull registry.gitlab.com/mono-homelab/nim-docker:rocky8

.PHONY: pull-rocky9
pull-rocky9:
	docker pull registry.gitlab.com/mono-homelab/nim-docker:rocky9

.PHONY: pull-ubuntu20
pull-ubuntu20:
	docker pull registry.gitlab.com/mono-homelab/nim-docker:ubuntu20

.PHONY: pull-ubuntu22
pull-ubuntu22:
	docker pull registry.gitlab.com/mono-homelab/nim-docker:ubuntu22

.PHONY: build
build: build-alpine build-rocky8 build-rocky9 build-ubuntu20 build-ubuntu22

.PHONY: build-ubuntu20
build-ubuntu20:
	docker buildx build --platform linux/amd64,linux/arm64 -f Dockerfile.ubuntu20 --push . \
		-t monofuel/nim:ubuntu20 \
		-t registry.gitlab.com/mono-homelab/nim-docker:ubuntu20

.PHONY: build-ubuntu22
build-ubuntu22:
	docker buildx build --platform linux/amd64,linux/arm64 -f Dockerfile.ubuntu22 --push . \
		-t monofuel/nim:ubuntu22 -t monofuel/nim:ubuntu \
		-t registry.gitlab.com/mono-homelab/nim-docker:ubuntu22

.PHONY: build-alpine
build-alpine:
	docker buildx build --platform linux/amd64,linux/arm64 -f Dockerfile.alpine --push . \
		-t monofuel/nim:alpine \
		-t registry.gitlab.com/mono-homelab/nim-docker:alpine
#	docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7,linux/arm/v6 -t monofuel/nim:latest --push .

.PHONY: build-rocky8
build-rocky8:
	docker buildx build --platform linux/amd64,linux/arm64 -f Dockerfile.rocky8 --push . \
		-t monofuel/nim:rocky8 \
		-t registry.gitlab.com/mono-homelab/nim-docker:rocky8

.PHONY: build-rocky9
build-rocky9:
	docker buildx build --platform linux/amd64,linux/arm64 -f Dockerfile.rocky9 --push . \
	  -t monofuel/nim:rocky9 -t monofuel/nim:latest -t monofuel/nim:rocky \
		-t registry.gitlab.com/mono-homelab/nim-docker:rocky9 \
		-t registry.gitlab.com/mono-homelab/nim-docker:latest

.PHONY: build-builder
build-builder:
	docker buildx build --platform linux/amd64 -f Dockerfile.builder --push . \
	  -t registry.gitlab.com/mono-homelab/nim-docker:builder 

# .PHONY: packer-init
# packer-init:
# 	packer init packer/rocky.pkr.hcl

# .PHONY: packer-build
# packer-build:
# 	packer build packer/rocky.pkr.hcl
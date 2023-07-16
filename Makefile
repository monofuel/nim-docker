
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

.PHONY: build
build: build-alpine build-rocky8 build-rocky9 build-ubuntu20 build-ubuntu22

.PHONY: build-ubuntu20
build-ubuntu20:
	docker buildx build --platform linux/amd64,linux/arm64 -t monofuel/nim:ubuntu20 -f Dockerfile.ubuntu20 --push .

.PHONY: build-ubuntu22
build-ubuntu22:
	docker buildx build --platform linux/amd64,linux/arm64 -t monofuel/nim:ubuntu22 -t monofuel/nim:ubuntu -f Dockerfile.ubuntu22 --push .

.PHONY: build-alpine
build-alpine:
	docker buildx build --platform linux/amd64,linux/arm64 -t monofuel/nim:alpine -f Dockerfile.alpine --push .
#	docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7,linux/arm/v6 -t monofuel/nim:latest --push .

.PHONY: build-rocky8
build-rocky8:
	docker buildx build --platform linux/amd64,linux/arm64 -t monofuel/nim:rocky8 -f Dockerfile.rocky8 --push .

.PHONY: build-rocky9
build-rocky9:
	docker buildx build --platform linux/amd64,linux/arm64 -t monofuel/nim:rocky9 -t monofuel/nim:latest -t monofuel/nim:rocky -f Dockerfile.rocky9 --push .

# .PHONY: packer-init
# packer-init:
# 	packer init packer/rocky.pkr.hcl

# .PHONY: packer-build
# packer-build:
# 	packer build packer/rocky.pkr.hcl
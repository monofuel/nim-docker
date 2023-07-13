
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

.PHONY: buildx
buildx:
	docker buildx build --platform linux/amd64,linux/arm64 -t monofuel/nim:alpine --push .
#	docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7,linux/arm/v6 -t monofuel/nim:latest --push .


.PHONY: packer-init
packer-init:
	packer init packer/*.pkr.hcl

.PHONY: packer-build
packer-build:
	packer build packer/*.pkr.hcl
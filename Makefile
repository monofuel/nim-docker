
.PHONY: build-amd64
build-amd64:
	docker build --no-cache -t monofuel/nim:amd64 .
	docker push monofuel/nim:amd64

.PHONY: build-arm32v6
build-arm32v6:
	docker build --no-cache -t monofuel/nim:arm32v6 .
	docker push monofuel/nim:arm32v6

.PHONY: manifest
manifest:
	docker manifest create --amend monofuel/nim:latest monofuel/nim:amd64 monofuel/nim:arm32v6
	docker manifest push monofuel/nim:latest

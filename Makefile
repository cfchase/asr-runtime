USERNAME := $(shell podman login --get-login quay.io)

build:
	podman build -t quay.io/$(USERNAME)/asr-runtime:latest -f docker/Dockerfile .

push:
	podman push quay.io/$(USERNAME)/asr-runtime:latest

run:
	podman run -ePORT=8080 -p8080:8080 quay.io/$(USERNAME)/asr-runtime:latest

test-v1:
	curl -H "Content-Type: application/json" localhost:8080/v1/models/model:predict -d @./scripts/v1_input.json | jq -r '.predictions[0].image.b64' | base64 -d > "example_output.png"

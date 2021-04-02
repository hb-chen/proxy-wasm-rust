.DEFAULT_GOAL := build

.PHONY: build

build:
	cargo build \
	--target wasm32-unknown-unknown \
	--release

run:
	envoy -c ./envoy.yaml \
	--concurrency 2 \
	--log-format '%v'

wasme.build:
	wasme build precompiled target/wasm32-unknown-unknown/release/hello_world.wasm \
	--tag webassemblyhub.io/hbchen/hello_world:v0.1

wasme.deploy:
	wasme deploy envoy webassemblyhub.io/hbchen/hello_world:v0.1 \
	--envoy-image=istio/proxyv2:1.8.4 \
	--bootstrap=envoy-bootstrap.yml

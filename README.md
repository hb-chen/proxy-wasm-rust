# Istio Wasm Rust Demo

Add new target
```shell
rustup update
rustup target add wasm32-unknown-unknown
```

编译
```shell script
make build
# or
cargo build --target wasm32-unknown-unknown --release
```

完成后`.wasm`文件在`target/wasm32-unknown-unknown/release/hello_world.wasm`，可以使用 [Envoy](#envoy) 或者 [Wasme](#wasme) 在本地测试。

启动后访问[http://localhost:8080/headers](http://localhost:8080/headers)，Header 中有`X-Hello`:
```json
{
  "headers": {
    "X-Hello": "Hello world from localhost:8080"
  }
}
```

## Envoy

[envoy install](https://www.envoyproxy.io/docs/envoy/latest/start/install)
```shell
envoy --version
envoy  version: d6a4496e712d7a2335b26e2f76210d5904002c26/1.17.1/Modified/DEBUG/BoringSSL
```

测试
```shell
make run
# or
envoy -c ./envoy.yaml --concurrency 1 --log-format '%v'
```

## Wasme

[wasme install](https://docs.solo.io/web-assembly-hub/latest/installation/)
```shell
wasme --version
wasme version 0.0.33
```

打包
```shell script
make wasme.build
# or
wasme build precompiled target/wasm32-unknown-unknown/release/hello_world.wasm --tag webassemblyhub.io/hbchen/hello_world:v0.1
```

测试
```shell script
make wasme.deploy
# or
wasme deploy envoy webassemblyhub.io/hbchen/hello_world:v0.1 --envoy-image=istio/proxyv2:1.8.4 --bootstrap=envoy-bootstrap.yml
```

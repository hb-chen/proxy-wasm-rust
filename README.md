# Istio Wasm Rust Demo

Add new target
```shell
rustup update
rustup target add wasm32-unknown-unknown
```

编译
```shell script
cargo build --target wasm32-unknown-unknown --release
```

打包
```shell script
wasme build precompiled target/wasm32-unknown-unknown/release/hello_world.wasm --tag webassemblyhub.io/hbchen/hello_world:v0.1
```

本地测试
```shell script
wasme deploy envoy webassemblyhub.io/hbchen/hello_world:v0.1 --envoy-image=istio/proxyv2:1.6.0 --bootstrap=envoy-bootstrap.yml
```

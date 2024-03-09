#! /bin/bash

# Run the tools necessary to make sure the code is ready for commit.

set -eo pipefail

R=$(pwd)
RUSTDOCFLAGS="-D warnings"

cargo +nightly fmt --check
cargo clippy -- -Dwarnings
cargo test
cargo test --release
cargo doc
cargo build
cargo build --release
cargo bench

cd $R/harper-wasm
wasm-pack build

cd $R/web
yarn install
yarn run format --check
yarn run lint 
yarn run check
yarn run build

# Maintainer: Diogo Iwasaki <67493856+Iwaslazkis@users.noreply.github.com>

pkgname=openai-codex
pkgver=0.122.0
pkgrel=2
pkgdesc='OpenAIs lightweight coding agent that runs in your terminal'
arch=(x86_64)
url='https://github.com/Iwaslazkis/openai-codex-pkgbuild'
license=(Apache-2.0)
depends=(
  bubblewrap
  bzip2
  glibc
  libcap
  libgcc
  openssl
  xz
  zlib
)
makedepends=(cargo)
checkdepends=(cargo-nextest git clang cmake dotslash nodejs python)
optdepends=(
  'git: allow for repository actions'
  'nodejs: enable the js_repl experimental tool'
  'ripgrep: accelerated large-repo search'
)
options=('!lto')
_patch_commit='09ebc34f17b84c4ec7550960b2f9c090f5dde5b7'
source=(
  "$pkgname-$pkgver.tar.gz::https://github.com/openai/codex/archive/refs/tags/rust-v$pkgver.tar.gz"
  "apply-patch-hooks-${_patch_commit}.patch::https://github.com/openai/codex/commit/${_patch_commit}.patch"
)
b2sums=(
  '7088872849a626565cec08976e3e7bf6434f2f9f4a0a58dfb960753578bb1ff272e70e21c367d58733013baa70c9bfe15ca3c2ee3f7b8b646c8970924857bd62'
  'da42011fa2e1fb5f61c3777306762ef9a834a95635cd0c44d69581dee1b5e8a0dd9d9546f2f3c74146df354e5500f9eb2946a34535b951e3f3cd40cc2369e232'
)

prepare() {
  cd "codex-rust-v$pkgver"

  patch -Np1 -i "$srcdir/apply-patch-hooks-${_patch_commit}.patch"

  cd codex-rs
  cargo fetch --target "$(rustc --print host-tuple)"
}

build() {
  cd "codex-rust-v$pkgver/codex-rs"

  export CARGO_PROFILE_RELEASE_LTO=thin
  cargo build --frozen --release --bin codex --bin codex-responses-api-proxy
}

check() {
  cd "codex-rust-v$pkgver/codex-rs"

  cargo test --frozen -p codex-core pre_tool_use_payload_uses_json_patch_input -- --exact --nocapture
  cargo test --frozen -p codex-core pre_tool_use_payload_uses_freeform_patch_input -- --exact --nocapture
  cargo test --frozen -p codex-core post_tool_use_payload_uses_patch_input_and_tool_output -- --exact --nocapture
}

package() {
  cd "codex-rust-v$pkgver/codex-rs"

  install -Dm755 -t "$pkgdir"/usr/bin \
    target/release/codex \
    target/release/codex-responses-api-proxy

  install -d "${pkgdir}/usr/share/bash-completion/completions" \
             "${pkgdir}/usr/share/zsh/site-functions" \
             "${pkgdir}/usr/share/fish/vendor_completions.d"
  "${pkgdir}/usr/bin/codex" completion bash > "${pkgdir}/usr/share/bash-completion/completions/codex"
  "${pkgdir}/usr/bin/codex" completion zsh > "${pkgdir}/usr/share/zsh/site-functions/_codex"
  "${pkgdir}/usr/bin/codex" completion fish > "${pkgdir}/usr/share/fish/vendor_completions.d/codex.fish"
}

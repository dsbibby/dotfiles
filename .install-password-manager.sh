#!/bin/sh

# exit immediately if bws is already in $PATH
type bws >/dev/null 2>&1 && exit

[ "$(uname -m)" = "x86_64" ] && arch="x86_64" || arch="aarch64"

# Get Latest Release
latest_version=$(curl -s https://raw.githubusercontent.com/bitwarden/sdk/main/crates/bws/Cargo.toml | grep -o '^version = ".*"' | grep -Eo "[0-9]+\.[0-9]+\.[0-9]+")

case "$(uname -s)" in
Darwin)
    asset_name="bws-${arch}-apple-darwin-${latest_version}.zip"
    ;;
Linux)
    asset_name="bws-${arch}-unknown-linux-gnu-${latest_version}.zip"
    ;;
*)
    echo "unsupported OS"
    exit 1
    ;;
esac

curl -o bws-cli.zip -Ls "https://github.com/bitwarden/sdk/releases/latest/download/${asset_name}"
mkdir -p ~/.local/bin
unzip bws-cli.zip -d ~/.local/bin
rm bws-cli.zip

if [ "$(uname -s)" = "Linux" ]; then
  # Patch bws to use brew glibc version
  brew install glibc patchelf 
  patchelf --set-interpreter "${HOMEBREW_CELLAR}/glibc/2.35_1/lib/ld-linux-x86-64.so.2" --set-rpath "${HOMEBREW_CELLAR}/glibc/2.35_1/lib" "~/.local/bin/bws"
fi

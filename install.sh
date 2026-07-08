#!/bin/sh
set -eu

APP_NAME="pwc"

# どのディレクトリから実行しても動くように、このスクリプトがある場所を取得する。
SCRIPT_DIR=$(CDPATH= cd "$(dirname "$0")" && pwd)

# 実行中のOSに対応する同梱バイナリを選ぶ。
case "$(uname -s)" in
  Darwin)
    OS="darwin"
    ;;
  *)
    echo "Error: ${APP_NAME} currently supports macOS only." >&2
    exit 1
    ;;
esac

# 実行中のCPUアーキテクチャに対応する同梱バイナリを選ぶ。
case "$(uname -m)" in
  arm64|aarch64)
    ARCH="arm64"
    ;;
  x86_64|amd64)
    ARCH="amd64"
    ;;
  *)
    echo "Error: unsupported CPU architecture: $(uname -m)" >&2
    exit 1
    ;;
esac

SOURCE="${SCRIPT_DIR}/bin/${APP_NAME}-${OS}-${ARCH}"

# 期待するビルド済みバイナリがリポジトリ内にない場合はここで終了する。
if [ ! -f "$SOURCE" ]; then
  echo "Error: bundled binary not found: $SOURCE" >&2
  exit 1
fi

# INSTALL_DIR が指定されていれば、その場所へインストールする。
# 未指定の場合は、書き込み可能な共通ディレクトリを優先し、無理ならユーザー配下へ入れる。
if [ "${INSTALL_DIR:-}" ]; then
  DEST_DIR="$INSTALL_DIR"
elif [ -d /usr/local/bin ] && [ -w /usr/local/bin ]; then
  DEST_DIR="/usr/local/bin"
else
  DEST_DIR="${HOME}/.local/bin"
fi

mkdir -p "$DEST_DIR"

# 選択した同梱バイナリを pwc というコマンド名でコピーし、実行権限を付ける。
DEST="${DEST_DIR}/${APP_NAME}"
cp "$SOURCE" "$DEST"
chmod 0755 "$DEST"

echo "Installed ${APP_NAME} to ${DEST}"

# インストール先にPATHが通っていない場合は、利用者に警告する。
case ":${PATH}:" in
  *":${DEST_DIR}:"*)
    ;;
  *)
    echo "Warning: ${DEST_DIR} is not in PATH." >&2
    echo "Add it to PATH or run ${DEST} directly." >&2
    ;;
esac

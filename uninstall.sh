#!/bin/sh
set -eu

APP_NAME="pwc"
REMOVED=0

# 指定したディレクトリに pwc コマンドがあれば削除する。
uninstall_from() {
  DIR=$1
  TARGET="${DIR}/${APP_NAME}"

  if [ -f "$TARGET" ]; then
    sudo rm "$TARGET"
    echo "Removed ${TARGET}"
    REMOVED=1
  fi
}

# INSTALL_DIR が指定されていれば、その場所だけをアンインストール対象にする。
# 未指定の場合は、install.sh が使う標準的なインストール先を順番に確認する。
if [ "${INSTALL_DIR:-}" ]; then
  uninstall_from "$INSTALL_DIR"
  SEARCHED_DIRS="$INSTALL_DIR"
else
  uninstall_from "/usr/local/bin"
  uninstall_from "${HOME}/.local/bin"
  SEARCHED_DIRS="/usr/local/bin ${HOME}/.local/bin"
fi

# 削除対象が見つからなかった場合は、利用者に探索した場所を伝える。
if [ "$REMOVED" -eq 0 ]; then
  echo "${APP_NAME} was not found in: ${SEARCHED_DIRS}" >&2
fi

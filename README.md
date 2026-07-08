# pwc

`pwc` は、現在のディレクトリの絶対パスを表示し、そのまま macOS のクリップボードへコピーする Go 製のコマンドです。

## 特徴

- 現在の作業ディレクトリを標準出力に表示します
- 表示したパスをクリップボードへコピーします
- macOS 標準の `pbcopy` を利用します

## 必要環境

- macOS

`pwc` は `pbcopy` を使うため、現在は macOS 向けです。

## インストール

Go 環境がない場合でも、同梱のビルド済みバイナリを使ってインストールできます。

```bash
./install.sh
```

デフォルトでは、書き込み可能な場合は `/usr/local/bin/pwc`、そうでない場合は `~/.local/bin/pwc` にインストールします。
インストール先を指定する場合:

```bash
INSTALL_DIR="$HOME/bin" ./install.sh
```

## アンインストール

```bash
./uninstall.sh
```

インストール先を指定していた場合:

```bash
INSTALL_DIR="$HOME/bin" ./uninstall.sh
```

ソースからインストールする場合:

```bash
go install github.com/syosyo-tech/pwc@latest
```

`go install` 後、`GOBIN` または `GOPATH/bin` に PATH が通っていることを確認してください。

## 使い方

任意のディレクトリで `pwc` を実行します。

```bash
pwc
```

例:

```bash
$ pwd
/Users/me/projects/example

$ pwc
/Users/me/projects/example
Copied to clipboard
```

実行すると、現在のディレクトリの絶対パスが標準出力に表示され、同じ内容がクリップボードへコピーされます。

## 開発

```bash
go test ./...
```

ローカルで実行する場合:

```bash
go run .
```

## ライセンス

MIT License

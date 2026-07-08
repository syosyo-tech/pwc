package main

import (
	"fmt"
	"os"
	"os/exec"
	"strings"
)

func main() {
	// 現在のディレクトリの絶対パスを取得する
	currentPath, err := os.Getwd()
	if err != nil {
		// パス取得に失敗した場合は、エラーを表示して異常終了する
		fmt.Fprintln(os.Stderr, "Error: failed to get current directory:", err)
		os.Exit(1)
	}

	// 取得したパスを標準出力に表示する
	fmt.Println(currentPath)

	// 取得したパスをクリップボードにコピーする
	if err := copyToClipboard(currentPath); err != nil {
		// コピーに失敗した場合は、エラーを表示して異常終了する
		fmt.Fprintln(os.Stderr, "Error: failed to copy to clipboard:", err)
		os.Exit(1)
	}

	// コピー成功メッセージを標準エラー出力に表示する
	fmt.Fprintln(os.Stderr, "Copied to clipboard")
}

// copyToClipboard は、引数で受け取った文字列をMacのクリップボードにコピーする関数
func copyToClipboard(text string) error {
	// macOSのクリップボードコピー用コマンド pbcopy を実行する準備
	cmd := exec.Command("pbcopy")

	// pbcopy の標準入力にコピーしたい文字列を渡す
	cmd.Stdin = strings.NewReader(text)

	// pbcopy を実行する
	return cmd.Run()
}

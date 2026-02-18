#!/bin/bash
# Hook: post-implement 自動lint+テスト
# トリガー: PostToolUse (Bash) でテスト/lint実行後に結果をフィードバック
# 目的: 「テスト書いたけど走らせてない」を防ぐ
#
# 注意: このスクリプトは PostToolUse で Edit/Write 後に呼ばれる。
# 実際のlint+テスト実行はimplementerのワークフローで行う。
# このフックは「実装ファイルが変更された」ことをClaude にリマインドする。

INPUT=$(cat)
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // empty')
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

# src/ 配下のファイルが編集された場合のみ反応
if echo "$FILE_PATH" | grep -qE '^.*/src/'; then
  echo '{"message": "src/ のファイルが変更されました。lint と テスト の実行を忘れずに。"}'
fi

exit 0

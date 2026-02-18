#!/bin/bash
# Hook: pre-commit バグ記録チェック
# トリガー: PreToolUse (Bash) で git commit を検知
# 目的: bugs/ にバグ記録がないコミットを拒否する

INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

# git commit コマンドかどうかチェック
if ! echo "$COMMAND" | grep -qE 'git\s+commit'; then
  exit 0
fi

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-.}"
BUGS_DIR="$PROJECT_DIR/bugs"

# bugs/ ディレクトリにファイルがあるか確認（テンプレートと.gitkeepを除く）
BUG_FILES=$(find "$BUGS_DIR" -name '*.md' ! -path '*/_templates/*' 2>/dev/null | head -1)

if [ -z "$BUG_FILES" ]; then
  echo "bugs/ にバグ記録が見つかりません。実装中にバグがなかった場合でも bugs/{task-id}-no-bugs.md を作成してください。" >&2
  exit 2
fi

exit 0

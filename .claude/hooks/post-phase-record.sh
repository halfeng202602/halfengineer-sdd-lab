#!/bin/bash
# Hook: post-phase フェーズ完了時の自動記録
# トリガー: Stop イベント
# 目的: フェーズ完了状態を docs/v4-experiments/ に自動記録
#
# 注意: Stop フックはClaude応答完了時に毎回呼ばれるため、
# フェーズ完了の判定はtasks.mdの状態変化で行う。

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-.}"
EXPERIMENTS_DIR="$PROJECT_DIR/docs/v4-experiments"

# docs/v4-experiments/ がなければ作成
mkdir -p "$EXPERIMENTS_DIR"

# 最新のtasks.mdを探す
TASKS_FILE=$(find "$PROJECT_DIR/specs" -name 'tasks.md' -type f 2>/dev/null | head -1)

if [ -n "$TASKS_FILE" ]; then
  # タスク進捗のスナップショットをログに追記
  TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
  echo "[$TIMESTAMP] Phase checkpoint recorded" >> "$EXPERIMENTS_DIR/phase-log.txt"
fi

exit 0

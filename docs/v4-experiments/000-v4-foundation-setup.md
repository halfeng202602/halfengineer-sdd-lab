# 000: v4 基盤整備（タスク0）

> 実施日: 2026-02-18

## やったこと

### 0-1: CLAUDE.md の再設計
- v3 の「Orchestration Rules をそのまま書く」スタイルから、v4 の「プロジェクトメモリ」として再定義
- 追加項目:
  - SDD バージョン: v4 を明記
  - Agent Teams 対応の注意事項（コンフリクト回避、コスト意識）
  - バグ記録必須化をフェーズ遷移ルールに反映（実装→レビュー遷移時にバグ記録存在確認を追加）
  - 新スラッシュコマンド（/phase-review, /phase-test, /status）を一覧に追加
- v3 のコンテキスト警告ルール（70%で /clear 推奨）は orchestrate.md 側に残し、CLAUDE.md からは削除

### 0-2: Hooks の設定
3つのフックスクリプトを `.claude/hooks/` に作成:

| Hook | ファイル | トリガー | 動作 |
|---|---|---|---|
| pre-commit バグ記録チェック | pre-commit-bug-check.sh | PreToolUse (Bash) | `git commit` 検知時に bugs/ のファイル存在を確認。なければ exit 2 でブロック |
| post-implement lint+テストリマインド | post-implement-lint-test.sh | PostToolUse (Edit/Write) | src/ 配下のファイル変更時にリマインドメッセージを返す |
| post-phase フェーズ記録 | post-phase-record.sh | Stop | Claude応答完了時に docs/v4-experiments/phase-log.txt にタイムスタンプを記録 |

settings.json の `hooks` セクションに3つとも登録済み。

### 0-3: Custom Slash Commands の追加
3つのコマンドを `.claude/commands/` に追加:

| コマンド | ファイル | 機能 |
|---|---|---|
| /phase-review | phase-review.md | reviewer エージェントを単体起動。design.md と突合してレビュー |
| /phase-test | phase-test.md | テスト全実行。結果サマリーを tasks.md に追記 |
| /status | status.md | tasks.md + bugs/ + review.md を読み取って進捗サマリー表示 |

## 起きたこと

- Hook の設計で Claude Code の Hooks 仕様を調査。イベントタイプ（PreToolUse, PostToolUse, Stop 等）とマッチャー、exit code の仕様を確認した
- `post-implement` フックは本来「implementer がタスク完了した後」に発火させたいが、Claude Code の Hooks はツールレベルのイベントしか提供しないため、ファイル変更検知 + リマインドという形に落とし着いた
- Agent Teams の有効化は `env` フィールドで環境変数として設定する必要があった（トップレベルキーではバリデーションエラー）

## 次にやること

- タスク1（バグ記録強制化）の動作確認: 実際に /orchestrate で何かを実装し、bugs/ にファイルが生成されるか確認
- タスク2（Agent Teams）の動作確認: 並列実行が実際に起動するか確認
- Hooks の実動作テスト: pre-commit フックがバグ記録なしコミットを実際にブロックするか確認

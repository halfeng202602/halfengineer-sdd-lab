# 002: Agent Teams の有効化（タスク2）

> 実施日: 2026-02-18

## やったこと

### settings.json の修正
- `env` フィールドに `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS: "1"` を追加
- 注意: トップレベルキーではなく `env` 内の環境変数として設定する必要があった

### orchestrate.md の修正
- Phase 3 に「Agent Teams 並列実行（v4）」セクションを追加:
  - 独立タスク（同一ファイル非編集）の並列実行ルール
  - Lead Agent による tasks.md 管理
  - Teammate のスコープ制限（割り当てタスクのみ）
  - 依存タスクは逐次実行のまま

### エージェントモデル配置の変更
- reviewer.md: model を `opus` → `sonnet` に変更（v4 のコスト最適化方針に従う）
- 他のエージェントは元から sonnet だったため変更なし

## 起きたこと

- Agent Teams は experimental 機能。`CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS` という環境変数名が示す通り、今後の仕様変更の可能性がある
- settings.json のスキーマバリデーションが厳密で、トップレベルに unknown key を置くとエラーになった → `env` フィールドで解決

## 観察ポイント（次回検証時に確認）

以下はまだ未検証。実際に /orchestrate で並列タスクを実行した際に確認する：

- [ ] Agent Teams が起動したか（Teammate が生成されたか）
- [ ] 各 Teammate が正しく独立したタスクだけ担当したか
- [ ] 同一ファイル編集のコンフリクトは起きなかったか
- [ ] Lead Agent がタスク完了を正しく把握したか
- [ ] Teammate 間のメッセージングは発生したか
- [ ] 逐次実行と比べて体感速度はどうだったか
- [ ] トークン消費量はどの程度増えたか
- [ ] 完了後、tasks.md の状態は正しいか
- [ ] Hooks（post-implement）が各Teammateで発火したか
- [ ] その後の Phase 4（レビュー）は正常に動いたか

## 次にやること

1. 独立した2つの小さい機能を用意して /orchestrate で実行
2. Agent Teams が実際に起動して並列実行されるか観察
3. 結果をこのファイルに追記する

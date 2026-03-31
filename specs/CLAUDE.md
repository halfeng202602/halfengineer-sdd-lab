# specs/ ディレクトリルール

## 構成

デフォルト（単一モード）：
```
specs/
  requirements.md   ← 全機能の要件（## {機能名} で追記）
  design.md         ← 全機能の設計（## {機能名} で追記）
  tasks.md          ← 全タスク管理（Source of Truth）
  _templates/       ← テンプレート（参照用）
```

大規模時（分割モード）：
```
specs/
  overview.md       ← 全体アーキテクチャ・機能間の関係
  {機能名}/
    requirements.md
    design.md
    tasks.md
```

## ルール
- **新しいファイルを作らない**。既存ファイルにセクションを追記して育てる
- 分割単位は「機能」であり「ユースケース」ではない
- tasks.md のステータスが進捗の Source of Truth
- テンプレートは _templates/ を参照する

## ステータス管理

ドキュメント: DRAFT → READY_FOR_REVIEW → APPROVED
タスク: TODO → IN_PROGRESS → DONE → BLOCKED

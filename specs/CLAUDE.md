# Specs ディレクトリルール

このディレクトリはSDD（スペック駆動開発）の中核。

## 構成ルール
- 機能ごとに `{feature-name}/` ディレクトリを作成する
- 各ディレクトリには以下の順で作成する：
  - Phase 1: requirements.md（PM が作成）
  - Phase 2: design.md + tasks.md（architect が作成）
  - Phase 4: review.md（reviewer が作成）
- テンプレートは `_templates/` を参照する

## ステータス管理

### ドキュメントステータス（各 .md ファイル末尾）
- `status: DRAFT` — 作成中
- `status: READY_FOR_REVIEW` — レビュー待ち（PO承認待ち）
- `status: APPROVED` — PO承認済み
- `status: NEEDS_REVISION` — 修正が必要

### タスクステータス（tasks.md 内の各タスク）
- `status: TODO` — 未着手
- `status: IN_PROGRESS` — 実装中
- `status: DONE` — 完了（テスト通過 + コミット済み）
- `status: BLOCKED` — 依存タスクが未完了

**tasks.md のタスクステータスがプロジェクト進捗の Source of Truth**。
セッション復帰時（/resume）はここを最優先で確認する。

## 命名規則
- ディレクトリ名: kebab-case（例: user-authentication）
- ファイル名: 固定（requirements.md, design.md, tasks.md, review.md）

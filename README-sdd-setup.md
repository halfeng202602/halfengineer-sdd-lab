# SDD ワークフロー設定ファイル一式 — 説明書

## ファイル構成

```
project-root/
├── CLAUDE.md                           # ルート: 全体ルール（薄い）
│
├── .claude/
│   ├── commands/
│   │   ├── orchestrate.md              # /orchestrate — 新機能開発
│   │   ├── bugfix.md                   # /bugfix — バグ修正
│   │   ├── resume.md                   # /resume — 途中復帰
│   │   └── change-request.md           # /change-request — 要件変更対応
│   └── agents/
│       ├── pm.md                       # 要件定義エージェント（Phase 1）
│       ├── researcher.md               # 技術調査エージェント（オンデマンド）
│       ├── architect.md                # 設計エージェント（Phase 2）
│       ├── implementer.md              # 実装＋テストエージェント（Phase 3）
│       ├── reviewer.md                 # レビューエージェント（Phase 4）
│       └── documenter.md              # ドキュメントエージェント（Phase 5）
│
├── docs/
│   └── steering/
│       ├── product.md                  # プロダクトビジョン（PO記入）
│       ├── tech.md                     # 技術スタック・方針（PO記入）
│       └── structure.md                # ディレクトリ構成・命名規則
│
├── specs/
│   ├── CLAUDE.md                       # スペック作成時のルール
│   └── _templates/
│       ├── requirements-template.md    # 要件定義テンプレート
│       ├── design-template.md          # 技術設計テンプレート
│       └── tasks-template.md           # タスク分解テンプレート
│
├── src/
│   └── CLAUDE.md                       # 実装時のルール
└── tests/
    └── CLAUDE.md                       # テスト時のルール
```

## アーキテクチャ

```
PO（ユーザー）
  │
  │ 自然言語で指示
  │ 例: 「ログイン機能を作りたい」
  │
  ▼
CLAUDE.md（オーケストレーター）
  │
  │ /orchestrate コマンドで起動
  │ POの意図を解釈 → サイズ判定 → 計画立案 → PO承認 → 委任
  │
  ├──► pm.md           要件定義（Phase 1）
  ├──► researcher.md    技術調査（オンデマンド・並列可）
  ├──► architect.md     技術設計 + タスク分解（Phase 2）
  ├──► implementer.md   実装 + テスト（Phase 3）
  ├──► reviewer.md      コードレビュー（Phase 4）
  └──► documenter.md    各フェーズの成果物に連動してドキュメント更新（Phase 5）
```

## 6フェーズ構成

| Phase | 名前 | 担当 | 成果物 |
|---|---|---|---|
| 1 | 要件定義 | pm | requirements.md |
| 2 | 設計＋タスク分解 | architect | design.md + tasks.md |
| 3 | 実装＋テスト | implementer | src/ + tests/ |
| 4 | レビュー | reviewer | review.md |
| 5 | ドキュメント | documenter | CHANGELOG, README等 |
| 6 | コミット | orchestrator | git commit（最終） |

リサーチャーは特定フェーズに属さず、オーケストレーターが必要と判断した任意のタイミングで呼び出す。

## 承認レベル（作業サイズ別）

| サイズ | 判定基準 | PO承認ゲート |
|---|---|---|
| Large | 新機能、設計変更を伴う | Phase 1, 2, 4（フル承認） |
| Medium | 既存機能の拡張、中規模バグ | Phase 2, 4（設計＋レビュー） |
| Small | 小バグ、リファクタ、文言修正 | Phase 4のみ |
| Trivial | ドキュメント修正、typo | 承認なし |

オーケストレーターが作業開始時にサイズを判定し、POに提示する。
POはサイズの変更を指示できる。

## ワークフロー詳細

```
PO: 「〇〇を作りたい」
  │
  ▼
orchestrator: 意図を解釈、サイズ判定、不明点をPOに質問
  │
  ▼
orchestrator: 作業計画を提示（サイズ・承認ポイント含む）
  │
  ▼
PO: 承認 ✅
  │
  ▼
[Phase 1] pm → requirements.md
           └→ documenter → onboarding.md 更新
  │
  ▼
PO: requirements.md を確認・承認 ✅（Large のみ）
  │
  ▼
[並列] researcher → 技術調査レポート（必要な場合のみ）
  │
  ▼
[Phase 2] architect → design.md + tasks.md
           └→ documenter → README, ADR 更新
  │
  ▼
PO: design.md + tasks.md を確認・承認 ✅（Large / Medium）
  │
  ▼
[Phase 3] implementer → Task-1 実装 + テスト + コミット
           └→ documenter → README (Usage), API docs 更新
          implementer → Task-2 ...
          implementer → Task-N ...
  │
  ▼
[Phase 4] reviewer → review.md
  │
  ▼
PO: レビュー結果を確認・承認 ✅（Trivial 以外）
  │     │
  │     └→ Critical あり → implementer に差し戻し → 再レビュー
  │
  ▼
[Phase 5] documenter → CHANGELOG 更新
  │
  ▼
[Phase 6] orchestrator → コミット整理 → 完了報告
```

## ドキュメンターの動き方

ドキュメンターは独立したフェーズ（Phase 5）を持つが、
各エージェントの成果物にも「反応して」動く：

```
pm 完了          → documenter: onboarding.md 追記
architect 完了   → documenter: README (Architecture) + ADR 作成
implementer 完了 → documenter: README (Usage) + API docs
全実装完了       → documenter: CHANGELOG 更新（Phase 5）
バグ修正完了     → documenter: CHANGELOG 追記
```

## Recovery（障害復旧）

**Source of Truth**: specs/{feature}/tasks.md のステータスカラム

- セッション復帰（/resume）時は tasks.md を最優先で確認する
- 未コミットの変更は `git status` で確認しPOに報告する
- コンテキスト上限に近づいたら `/clear` を提案する

## ルールの分散構造

```
CLAUDE.md（ルート）
  ├─ 全体フロー・承認ゲート・Recovery Rules（薄い）
  │
  ├─ .claude/agents/*.md
  │    └─ 各エージェントの詳細ルール（厚い）
  │
  ├─ .claude/commands/orchestrate.md
  │    └─ ワークフロー実行手順
  │
  └─ {dir}/CLAUDE.md
       └─ ディレクトリ固有のルール（そこで作業する時だけ読まれる）
```

**設計意図**: CLAUDE.md を薄く保ち、詳細は使う時だけ読み込まれるファイルに分散する。
これにより Claude のコンテキスト効率を最大化する。

## 使い方

### 初期セットアップ
1. このテンプレートをプロジェクトルートにコピーする
2. CLAUDE.md の [プロジェクト名], [Stack] 等を埋める
3. docs/steering/product.md にプロダクトビジョンを記入する
4. docs/steering/tech.md に技術スタック・方針を記入する
5. docs/steering/structure.md をプロジェクトに合わせて調整する

### POが使うコマンド

```bash
# 新機能開発
/orchestrate ログイン機能を作りたい

# バグ修正
/bugfix ログインボタンを押しても画面が遷移しない

# セッション切断後の復帰
/resume

# 実装途中の要件変更
/change-request MFAも追加したい
```

POはこの4つだけ覚えればいい。あとはオーケストレーターが全部仕切る。

## コスト最適化

| エージェント | モデル | 理由 |
|---|---|---|
| オーケストレーター | opus | 意図解釈・計画立案に高い能力が必要 |
| PM / アーキテクト / レビュアー | opus | 設計品質・レビュー品質が最重要 |
| 実装者 | sonnet | 定型作業はコスト効率重視 |
| リサーチャー | sonnet | 量をこなす作業 |
| ドキュメンター | haiku | 軽量タスク、最速・最安 |

設計フェーズ opus → 実装フェーズ sonnet でコスト約60%削減が目安。

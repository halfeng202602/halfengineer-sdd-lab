# プロジェクト構造・命名規則

> ディレクトリ構成と命名規則。Architectが参照・更新する。

## ディレクトリ構成

```
src/
  app/          ← ページ・ルーティング
  components/   ← UIコンポーネント
  lib/          ← ユーティリティ・ビジネスロジック
  hooks/        ← カスタムフック
  types/        ← 型定義
  config/       ← 設定ファイル
tests/          ← テストファイル（src/ 配下には置かない）
specs/          ← 仕様・設計・タスク管理
docs/           ← ドキュメント
bugs/           ← バグ記録
```

## 命名規則

| 対象 | 規則 | 例 |
|---|---|---|
| コンポーネント | PascalCase.tsx | UserProfile.tsx |
| ユーティリティ | camelCase.ts | formatDate.ts |
| 型定義 | camelCase.ts | user.ts |
| テスト | {元ファイル}.test.ts | formatDate.test.ts |
| ディレクトリ | kebab-case | user-profile/ |
| 変数・関数 | camelCase | getUserName |
| 型・インターフェース | PascalCase | UserProfile |
| 定数 | UPPER_SNAKE_CASE | MAX_RETRY_COUNT |

## モジュール分割方針
- 機能凝集（関連する機能をまとめる）
- 依存方向: components → lib → types
- 循環依存の禁止

## テスト配置ルール
- テストファイルはすべて tests/ 配下に置く
- src/ 配下に .test / .spec / __tests__ は置かない

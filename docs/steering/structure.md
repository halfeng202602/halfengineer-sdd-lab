# Project Structure Rules

> ディレクトリ構成と命名規則。
> architect と implementer が新しいファイルを作る時の基準。

## ディレクトリ構成

```
src/
├── app/                # Next.js App Router ページ
│   ├── (auth)/         # 認証関連ページ
│   ├── (dashboard)/    # ダッシュボード
│   ├── api/            # API Routes
│   └── layout.tsx
├── components/
│   ├── ui/             # 汎用UIコンポーネント（shadcn等）
│   └── features/       # 機能固有のコンポーネント
│       └── {feature}/  # フィーチャーごとにディレクトリ
├── lib/                # ユーティリティ・共通ロジック
│   ├── db/             # DB関連（Prismaクライアント等）
│   ├── auth/           # 認証ロジック
│   └── utils/          # 汎用ユーティリティ
├── hooks/              # カスタムフック
├── types/              # 型定義
└── config/             # 設定ファイル
```

（プロジェクトに合わせて変更すること）

---

## 命名規則

### ファイル名
- コンポーネント: `PascalCase.tsx`（例: `LoginForm.tsx`）
- ユーティリティ: `camelCase.ts`（例: `formatDate.ts`）
- 型定義: `camelCase.ts`（例: `user.ts`）
- テスト: `{元ファイル名}.test.ts`（例: `formatDate.test.ts`）

### ディレクトリ名
- kebab-case（例: `user-auth/`, `api-client/`）

### 変数・関数
- camelCase（例: `getUserById`, `isAuthenticated`）

### 型・インターフェース
- PascalCase（例: `User`, `AuthResponse`）
- interface を type より優先する

### 定数
- UPPER_SNAKE_CASE（例: `MAX_RETRY_COUNT`）

---

## モジュール分割の方針

- **機能凝集**: 関連するコードは同じディレクトリに置く
- **依存方向**: `components` → `lib` → `types` の一方向。逆方向の依存は禁止
- **再エクスポート**: 各ディレクトリに `index.ts` を置いて公開APIを制御する

---

## 新規ファイル作成時のチェックリスト

- [ ] 命名規則に従っているか
- [ ] 適切なディレクトリに配置されているか
- [ ] 依存方向が正しいか
- [ ] テストファイルも作成したか

---

## テスト配置ルール

テストは **すべて `tests/` ディレクトリ配下** に配置する。
`src/` 配下にテストファイル（`*.test.ts`, `*.spec.ts`, `__tests__/`）を置くことは禁止。

```
tests/
├── unit/           # ユニットテスト（src/ のディレクトリ構造をミラー）
├── integration/    # 結合テスト
└── e2e/            # E2Eテスト（必要に応じて）
```

例: `src/lib/utils/formatDate.ts` のテスト → `tests/unit/lib/utils/formatDate.test.ts`

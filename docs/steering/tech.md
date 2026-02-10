# Tech Stack & Policy

> プロジェクト開始時に記入する。
> エージェント（特に architect, implementer）の技術判断の基準。

## 技術スタック

### フロントエンド
- Framework: {例: Next.js 14 (App Router)}
- UI: {例: Tailwind CSS + shadcn/ui}
- State: {例: Zustand}
- Language: {例: TypeScript (strict mode)}

### バックエンド
- Runtime: {例: Node.js 20}
- Framework: {例: Next.js API Routes}
- ORM: {例: Prisma}
- Language: {例: TypeScript}

### データベース
- Primary: {例: PostgreSQL 16 (Supabase)}
- Cache: {例: なし（将来Redis検討）}

### インフラ
- Hosting: {例: Vercel}
- CI/CD: {例: GitHub Actions}
- Monitoring: {例: Vercel Analytics}

### テスト
- Unit: {例: Vitest}
- E2E: {例: Playwright}
- Coverage目標: {例: 80%}

---

## パッケージマネージャー
{例: pnpm}

## Node.jsバージョン
{例: 20.x（.nvmrc で管理）}

---

## 技術方針

### 採用基準
- 新しいライブラリは以下を満たすこと：
  - GitHub Stars {例: 1000+}
  - 最終更新が {例: 6ヶ月以内}
  - TypeScript サポートあり
  - ライセンスが {例: MIT / Apache 2.0}

### 禁止事項
- {例: any 型の使用禁止}
- {例: console.log でのデバッグ（loggerを使う）}
- {例: default export 禁止（named export のみ）}

### コーディング規約
- {例: ESLint + Prettier で自動フォーマット}
- {例: 関数は40行以内}
- {例: コメントは「なぜ」を書く。「何を」は書かない}

---

## 外部サービス

| サービス | 用途 | 環境変数 |
|---|---|---|
| {例: Supabase} | {DB + Auth} | {SUPABASE_URL, SUPABASE_ANON_KEY} |
| {例: Resend} | {メール送信} | {RESEND_API_KEY} |

---

## 環境

| 環境 | URL | 用途 |
|---|---|---|
| local | localhost:3000 | 開発 |
| staging | {URL} | 検証 |
| production | {URL} | 本番 |

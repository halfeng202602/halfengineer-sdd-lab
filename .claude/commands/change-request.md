# /change-request — 仕様変更対応

実装途中での要件変更・追加対応。

## Step 1: 変更内容の把握

POから変更内容を確認する。

## Step 2: 影響分析

| 影響度 | 判定基準 | 対応 |
|---|---|---|
| Small | design.md の範囲内、新規タスク1-2個 | tasks.md にタスク追加して実装 |
| Medium | design.md の一部修正が必要 | design.md 更新 → 追加実装 |
| Large | requirements.md の見直しが必要 | 別機能として /orchestrate を推奨 |

## Step 3: POに報告

影響度と対応方針をPOに報告し、承認を得る。

## Step 4: 実行

承認後、対応を実行する。
変更内容は requirements.md の変更履歴セクションに記録する。

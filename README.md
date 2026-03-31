# halfengineer-sdd-lab v7

非エンジニアがAIに開発を丸投げするための実験テンプレート。
「仕様書を書いたらAIが作ってくれる」を試してみた記録です。

## v7の特徴

- **最小限のファイルを育てる**: specs/ は3ファイルだけ。セクション追記で育てる
- **機能単位**: ユースケースではなく機能単位で分割
- **TDD + 受入基準**: テストは受入基準カバーのみ必須
- **仕様は生きている**: 実装で判明した事実はP4で仕様に書き戻す
- **5フェーズ**: 要件定義→設計→実装→レビュー→ドキュメント
- **4エージェント + orchestrator**: pm, architect, implementer, reviewer, researcher

## 使い方

1. テンプレートをプロジェクトにコピー
2. `CLAUDE.md` の技術スタック・Commands を埋める
3. `SPEC.md` にプロダクト概要と機能を記入
4. `docs/steering/` の3ファイルを埋める
5. Claude Code で `/orchestrate {やりたいこと}` を実行

## ディレクトリ構成

```
CLAUDE.md           ← オーケストレーションルール（メイン）
SPEC.md             ← プロダクト全体像（POが記入）
specs/
  requirements.md   ← 全機能の要件（育てるファイル）
  design.md         ← 全機能の設計（育てるファイル）
  tasks.md          ← 全タスク管理（Source of Truth）
  _templates/       ← テンプレート（参照用）
docs/steering/
  product.md        ← プロダクトビジョン
  tech.md           ← 技術スタック
  structure.md      ← 構造・命名規則
.claude/
  agents/           ← エージェント定義
  commands/         ← スラッシュコマンド
```

## v6からの主な変更

- specs/{feature}/ フォルダ分割を廃止 → 単一ファイルに統合
- security エージェント廃止 → reviewer に統合
- documenter エージェント廃止 → orchestrator が直接実行
- バグなし記録（no-bugs.md）廃止
- review.md 廃止 → 仕様への書き戻しが成果物
- 外部レビュー / エージェントメモリ / コンテキストリセット 廃止
- テスト範囲を受入基準カバーのみに絞り込み
- 承認レベルを4段階から2段階に簡略化
- 規模分岐（単一モード / 分割モード）を追加

## ブログ

- [① AI開発、思ったほど楽じゃなかった話](https://note.com/halfeng202602/n/na8fbe4649f0e)
- [② スペック駆動開発にたどり着くまで](https://note.com/halfeng202602/n/n9895c4570053)
- [③ テンプレv3、検証してみた](https://note.com/halfeng202602/n/na931d69cb82e)
- [④ テンプレv4、シェフが同時に動き出した](https://note.com/halfeng202602/n/nc35e1335e4cd)
- [⑤ 自作AI開発テンプレv5、地味だけど大事なアップデート](https://note.com/halfeng202602/n/ndee99bde4abb)

## 注意

これは個人の実験プロジェクトです。AIが生成したコードの品質は人間が確認してください。

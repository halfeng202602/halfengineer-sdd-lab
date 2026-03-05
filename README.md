# halfengineer-sdd-lab

非エンジニアがAIに開発を丸投げするための実験テンプレート。

「仕様書を書いたらAIが作ってくれる」を試してみた記録です。
筆者が勝手にスペック駆動開発（SDD）と呼んでいます。


### 従来のAI開発との違い

| | チャットベース | SDD |
|---|---|---|
| 指示の出し方 | その場でプロンプトを書く | 事前に仕様書を用意する |
| 品質の再現性 | 人とプロンプト次第 | テンプレートで標準化 |
| 承認フロー | なし（AIが自走） | planning → approval → execution |
| 対象ユーザー | エンジニア | PO/PM（非エンジニア含む） |

### ワークフロー（6フェーズ）

1. 要件定義（PMエージェント）
2. 設計＋タスク分解（Architectエージェント）
3. 実装＋テスト（Implementerエージェント）— Agent Teamsで並列実行可能
4. レビュー（Reviewerエージェント）
5. ドキュメント（Documenterエージェント）
6. コミット整理

## v5の主な変更点

- **Living Spec（spec-anchored）**: 実装で判明した事実を仕様に書き戻す双方向フィードバック
- **Steering Docs 書き戻し**: PMがPOから得た情報を product.md / tech.md / structure.md に自動反映。プレースホルダが埋まらない問題を解消
- **ユースケース単位イテレーション**: SPEC.md のユースケースを1つずつ /orchestrate で回す。複数同時進行しない
- **PMの必須確認チェックリスト**: ユーザー視点・ビジネス視点・データ制約・エッジケースの4カテゴリで質問を強制
- **Custom Slash Commands**: /phase-review、/phase-test、/status、/change-request を追加
- **Agent Teams**: 独立タスクの並列実行に対応
- **バグ記録の強制化**: 行動原則 + レビュー + Hooks の三重チェック

## 使い方

1. テンプレートをプロジェクトにコピー
2. `CLAUDE.md` を自分のプロジェクトに合わせて編集
3. Claude Code で `/orchestrate {やりたいこと}` を実行

## ブログ

- [① AI開発、思ったほど楽じゃなかった話](https://note.com/halfeng202602/n/na8fbe4649f0e)
- [② スペック駆動開発にたどり着くまで](https://note.com/halfeng202602/n/n9895c4570053)
- [③ テンプレv3、検証してみた](https://note.com/halfeng202602/n/na931d69cb82e)
- [④ テンプレv4、シェフが同時に動き出した](https://note.com/halfeng202602/n/nc35e1335e4cd)
- [⑤ 自作AI開発テンプレv5、地味だけど大事なアップデート](https://note.com/halfeng202602/n/ndee99bde4abb)
## 注意

これは個人の実験プロジェクトです。AIが生成したコードの品質は人間が確認してください。

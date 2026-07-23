# dotfiles

[Claude Code](https://claude.com/claude-code) の個人設定を管理するリポジトリ。

## 構成

```
.dotfiles/
├── install.sh                 # ~/.claude 配下へシンボリックリンクを張る
└── claude/
    ├── settings.json          # 権限 / フック / モデル / statusLine など
    ├── CLAUDE.md              # 全プロジェクト共通のグローバル指示（日本語会話ルール等）
    ├── statusline-command.sh  # ステータスライン表示スクリプト
    ├── commands/
    │   └── hard-review.md     # カスタムスラッシュコマンド /hard-review
    └── plugins/
        └── known_marketplaces.json  # 登録済みプラグインマーケットプレイス
```

## 各設定の狙い

| ファイル | ポイント |
| --- | --- |
| `settings.json` | `permissions` を allow / deny / ask で三段管理。`git push --force` や `rm` などの危険操作をブロック / 確認に。`CLAUDE_AUTOCOMPACT_PCT_OVERRIDE=70` で早めに自動コンパクト。`Stop` / `PermissionRequest` フックで効果音を鳴らす。`statusLine` でコスト・コンテキスト残量を常時表示。 |
| `CLAUDE.md` | 「常に日本語」「結論ファースト」「コメントを書かない」など、全プロジェクトに効く個人ルール。 |
| `statusline-command.sh` | モデル名・コスト・追加/削除行数・コンテキスト使用率を色付きで表示。 |
| `commands/hard-review.md` | 問題がなくなるまでレビューと修正を繰り返す `/hard-review`。 |

## インストール

```bash
git clone <this-repo> ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

`install.sh` は既存ファイルをバックアップしてからシンボリックリンクを張ります。

## 注意

- APIキーや鍵、社外秘は含んでいません。
- パスにユーザー名（`onodaosamu`）が含まれる箇所があります。フォークする場合は自分の環境に合わせて書き換えてください。

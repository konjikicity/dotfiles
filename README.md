# dotfiles

[Claude Code](https://claude.com/claude-code) を含む個人設定を管理するリポジトリ。

## 構成

```
.dotfiles/
├── install.sh                 # ~/ 配下へシンボリックリンクを張る
├── claude/                    # ~/.claude 配下
│   ├── settings.json          # 権限 / フック / モデル / statusLine など
│   ├── CLAUDE.md              # 全プロジェクト共通のグローバル指示（日本語会話ルール等）
│   ├── statusline-command.sh  # ステータスライン表示スクリプト
│   ├── commands/
│   │   └── hard-review.md     # カスタムスラッシュコマンド /hard-review
│   └── plugins/
│       └── known_marketplaces.json  # 登録済みプラグインマーケットプレイス
└── home/                      # ~/ 直下・~/.config 配下
    ├── .zshrc                 # zsh メイン設定
    ├── .zprofile              # ログインシェル用
    ├── .zshenv               # 全 zsh 共通の環境変数
    ├── .p10k.zsh             # Powerlevel10k テーマ設定
    ├── .fzf.zsh              # fzf 連携
    ├── .gitconfig            # Git ユーザー / エイリアス設定
    ├── .gitignore_global     # Git グローバル無視設定
    ├── .tmux.conf            # tmux 設定
    ├── .tmux-powerlinerc     # tmux-powerline 設定
    └── .config/
        ├── alacritty/        # Alacritty ターミナル設定
        ├── ghostty/          # Ghostty ターミナル設定
        ├── karabiner/        # Karabiner-Elements キーリマップ
        ├── peco/             # peco 設定
        ├── tmux-powerline/   # tmux-powerline テーマ
        ├── git/              # Git 追加設定
        ├── psysh/            # PsySH（PHP REPL）設定
        └── starship.toml     # Starship プロンプト設定
```

## インストール

```bash
git clone <this-repo> ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

# Dotfiles

使用 [chezmoi](https://www.chezmoi.io/) 管理的配置文件仓库。

## 配置

- [Alacritty](./dot_config/alacritty) — GPU 加速终端
- [Kitty](./dot_config/kitty) — 功能丰富的终端模拟器
- [Ghostty](./dot_config/ghostty) — 快速终端模拟器
- [WezTerm](./dot_config/wezterm) — Rust 编写的跨平台终端
- [Neovim](./dot_config/nvim) — 基于 Lua 的 Vim 配置 (LazyVim)
- [Helix](./dot_config/helix) — 后现代模态编辑器
- [Neovide](./dot_config/neovide) — Neovim 的 GUI 前端
- [Zsh](./dot_zshrc) — 配合 oh-my-zsh 的 zsh 配置
- [Tmux](./dot_config/tmux) — 终端复用器，使用 TPM 管理插件
- [Zellij](./dot_config/zellij) — Rust 编写的终端工作区
- [Starship](./dot_config/starship) — 跨 Shell 提示符主题
- [Atuin](./dot_config/private_atuin) — Shell 历史记录管理
- [Commitizen](./dot_czrc) — 规范化 commit message
- [Yabai](./dot_config/yabai) — 平铺式窗口管理器
- [SKHD](./dot_config/skhd) — 简单热键守护进程
- [SketchyBar](./dot_config/sketchybar) — 替代 macOS 菜单栏的状态栏
- [Sesh](./dot_config/sesh) — Tmux 会话快速切换
- [Muxie](./dot_config/muxie) — Tmux 会话布局管理
- [Tmuxinator](./dot_config/tmuxinator) — 预定义 Tmux 项目会话
- [Lazygit](./dot_config/lazygit) — 终端 Git UI
- [Yazi](./dot_config/yazi) — 终端文件管理器
- [Homebrew](./dot_config/homebrew) — Brewfile 包管理清单
- [OpenCode](./dot_config/opencode) — AI 编程助手配置
- [Btop](./dot_config/btop) — 资源监控器
- [Bpytop](./dot_config/bpytop) — Python 资源监控器
- [Fastfetch](./dot_config/fastfetch) — 系统信息展示

### 1. 安装 chezmoi

```sh
sh -c "$(curl -fsLS get.chezmoi.io)"
```

### 2. 初始化并应用配置

```sh
chezmoi init --apply https://github.com/leeonon/dotfiles.git
```

### 3. 安装 TPM (Tmux 插件管理器)

```sh
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
```

启动 tmux 后按 `prefix + I`（默认 `Ctrl+b` 然后 `I`）安装所有插件。

### 4. 安装 Homebrew 依赖

```sh
brew bundle --file ~/.config/homebrew/Brewfile
```

### chezmoi 命令

| 命令                  | 说明                       |
| --------------------- | -------------------------- |
| `chezmoi apply`       | 将仓库更改应用到系统       |
| `chezmoi diff`        | 查看仓库与系统的差异       |
| `chezmoi status`      | 查看文件变更状态           |
| `chezmoi edit <file>` | 编辑源文件（使用 VS Code） |
| `chezmoi add <file>`  | 将新文件纳入 chezmoi 管理  |
| `chezmoi re-add`      | 重新同步已变更的目标文件   |

---

![Neovim](./images/nvim-home.png)
![Neovim](./images/nvim.png)
![Neovide](./images/neovide.png)
![Alacritty](./images/alacritty.png)

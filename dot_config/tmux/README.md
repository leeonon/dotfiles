## tpm

配置文件依赖TPM插件管理， 需要确保已经安装了 TPM

```sh
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
```

打开一个 tmux 会话，然后按下 prefix + I（通常 prefix 是 Ctrl+b）。这将强制 tpm 安装所有插件。

一定要确保 `tmux.conf` 中有以下内容

```sh
# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
# Add other plugins here

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
```

tmux kill-server 关闭所有回话

tmux source-file .config/tmux/tmux.conf 重载配置文件

## 某些tmux 插件无法通过 tpm 安装问题

例如 之前安装过 catppuccin/tmux 插件，就会在 plugin 下创建一个 tmux 文件夹，这时候再安装 rose-pine/tmux 。因为已经有了 tmux 文件夹了，所以不会重新安装，解决办法是手动删除 tmux 文件夹，然后 Prefix + I 进行安装 -> https://github.com/rose-pine/tmux/issues/28


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

 tmux source-file .config/tmux/tmux.conf  重载配置文件
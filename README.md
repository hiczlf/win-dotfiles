# win-dotfiles

我的 dotfiles，用于管理 Windows 环境配置。终端使用 PowerShell 7.x。

# 我的工具

* chezmoi: 管理dotfiles
* fnm: 管理node版本
* zoxide: 在不同的目录跳转
* Vim: 文本编辑器



# 安装

先安装 PowerShell 7、chezmoi 和 fnm。在本项目根目录打开 PowerShell，预览并应用配置：

```powershell
chezmoi --source "$PWD" diff
chezmoi --source "$PWD" apply
```

使用显式的 `--source`，确保应用的是当前仓库的配置。应用后重新打开 PowerShell。

## 管理的配置

* `Documents/PowerShell/Microsoft.PowerShell_profile.ps1`：映射到 `$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`，包含代理环境变量及 fnm 初始化。
* `_vimrc`：映射到 `$HOME\_vimrc`，原样导入本机 Vim 安装目录中的配置，包含 Vim 示例配置及 Windows diff 支持。使用前需安装 Vim。
* 代理使用本机 `7890` 端口，使用前请确认本机代理服务的端口一致。
* zoxide 已列入工具清单，当前 profile 尚未配置其初始化。

如果系统重定向了 Documents 文件夹，先运行 `$PROFILE` 检查实际路径；当前目录布局适用于默认的 `$HOME\Documents` 路径。

## 更新配置

直接修改仓库中的 profile 后，在项目根目录运行上述 `diff` 和 `apply` 命令。

如果修改的是系统中的 `$PROFILE`，在 PowerShell 7 中从项目根目录同步回仓库：

```powershell
chezmoi --source "$PWD" add "$PROFILE"
git diff
```

如果修改的是用户目录中的 Vim 配置，在项目根目录同步回仓库：

```powershell
chezmoi --source "$PWD" add "$HOME\_vimrc"
git diff
```

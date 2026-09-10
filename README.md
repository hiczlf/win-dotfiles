# win-dotfiles

我的 dotfiles，用于管理 Windows 环境配置。终端使用 PowerShell 7.x。

# 我的工具

* chezmoi: 管理dotfiles
* fnm: 管理node版本
* zoxide: 在不同的目录跳转
* Vim: 文本编辑器



# 安装

先安装 PowerShell 7、chezmoi、fnm 和 zoxide，并使用 `chezmoi init <仓库地址>` 初始化本仓库。

## 日常使用

在 PowerShell 中先进入 chezmoi 管理的仓库目录，再预览并应用配置：

```powershell
chezmoi cd
chezmoi diff
chezmoi apply
```

`chezmoi cd` 会在仓库目录启动一个新的 PowerShell，输入 `exit` 返回原来的终端。修改 PowerShell profile 并应用后，重新打开 PowerShell 使配置生效。

## 管理的配置

* `.chezmoi.toml.tmpl`：chezmoi 自身的配置模板，执行 `chezmoi init` 时生成 `$HOME\.config\chezmoi\chezmoi.toml`，让 `chezmoi cd` 使用 PowerShell 7（`pwsh`）。
* `Documents/PowerShell/Microsoft.PowerShell_profile.ps1`：映射到 `$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`，包含代理环境变量、fnm 初始化及 zoxide 初始化。
* `_vimrc`：映射到 `$HOME\_vimrc`，原样导入本机 Vim 安装目录中的配置，包含 Vim 示例配置及 Windows diff 支持。使用前需安装 Vim。
* 代理使用本机 `7890` 端口，使用前请确认本机代理服务的端口一致。
* zoxide 通过 profile 末尾的 `zoxide init powershell` 初始化；使用前需安装 zoxide，并确保 `zoxide` 命令可用。应用配置后重新打开 PowerShell 即可加载。

如果系统重定向了 Documents 文件夹，先运行 `$PROFILE` 检查实际路径；当前目录布局适用于默认的 `$HOME\Documents` 路径。

## 更新配置

以下操作均先通过 `chezmoi cd` 进入仓库目录。

chezmoi 自身的配置由 `.chezmoi.toml.tmpl` 管理。修改模板后，运行 `chezmoi init` 重新生成本地配置；普通 `apply` 不会重新生成它。通过 `chezmoi edit-config` 修改本地配置后，需将需要同步的设置更新到该模板。

直接修改仓库中的 profile 后，运行 `chezmoi diff` 预览，再运行 `chezmoi apply` 应用。

如果修改的是系统中的 `$PROFILE`，在 PowerShell 7 中从项目根目录同步回仓库：

```powershell
chezmoi add "$PROFILE"
git diff
```

如果修改的是用户目录中的 Vim 配置，在项目根目录同步回仓库：

```powershell
chezmoi add "$HOME\_vimrc"
git diff
```

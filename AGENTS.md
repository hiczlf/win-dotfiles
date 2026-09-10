# 项目说明

这是使用 chezmoi 管理的 Windows dotfiles 仓库，终端使用 PowerShell 7。沟通和文档默认使用中文，命令示例使用 PowerShell 语法。

## 配置位置

| 仓库文件 | 用途或目标位置 |
| --- | --- |
| `Documents/PowerShell/Microsoft.PowerShell_profile.ps1` | `$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`，配置代理、fnm 和 zoxide |
| `_vimrc` | `$HOME\_vimrc`，Vim 配置及 Windows diff 支持 |
| `.chezmoi.toml.tmpl` | chezmoi 自身的配置模板，通过 `chezmoi init` 生成本地配置；当前指定 `chezmoi cd` 启动 `pwsh` |
| `.chezmoiignore` | 排除不应部署到用户目录的仓库文件 |
| `README.md` | 工具清单、安装、日常使用和更新配置说明 |

## 修改约定

- 开始前检查 `git status` 和相关文件，保留用户已有修改，避免无关重写。
- 默认修改仓库中的源文件。用户要求应用或同步本机配置时，再执行相应的 `chezmoi apply`、`chezmoi init` 或 `chezmoi add`；已有授权无需重复确认。
- `.chezmoi.toml.tmpl` 的变更需要 `chezmoi init` 重新生成本地配置，普通 `apply` 不会完成这一步。
- PowerShell profile 中保留代理、fnm、zoxide 的初始化顺序，zoxide 初始化放在末尾。除非任务要求，不改动代理地址和端口。
- 新增配置时遵循 chezmoi 文件命名和映射规则；辅助文档和开发文件应加入 `.chezmoiignore`。`AGENTS.md` 已在其中，无需部署到用户目录。
- 不将密码、令牌或本机状态数据库加入仓库。
- 工具、配置行为或使用流程有变化时，同步更新 README。工具出现在清单中不代表当前执行环境已安装它。

## 命令与验证

- 用户日常流程是 `chezmoi cd` → `chezmoi diff` → `chezmoi apply`，README 保持这一写法。AI 已在仓库中时无需再启动 `chezmoi cd` 子 shell。
- 使用 chezmoi 前确认其源目录对应当前仓库；检查其他 checkout 时可用 `--source` 显式指定路径。
- 搜索内容优先使用 `rg`，查找文件使用 `rg --files`；命令不可用时使用 PowerShell 替代。
- 修改后执行 `git diff --check` 并检查实际差异。仅文档变更无需运行配置或新增测试。
- PowerShell 脚本修改优先使用 `System.Management.Automation.Language.Parser.ParseFile` 做语法检查，不为验证而直接加载整个 profile；语法检查不能替代依赖工具的运行验证。
- 需要检查部署差异且 chezmoi 可用时运行 `chezmoi diff`。不要仅为验证源文件而修改本机配置。
- 完成后简要说明修改内容、验证结果及是否已应用到本机；不能执行的检查应如实说明。

# claude的安装与配置

## 1. 安装

### 安装方法

- 按照[文档说明](https://code.claude.com/docs/zh-CN/setup)，根据自己的系统安装 `claude-code` 工具
- （可选）强烈推荐安装 [`cc-switch`](https://ccswitch.io/zh/docs?section=getting-started&item=installation) 配置管理工具

在安装好 claude 后，输入以下命令启动工具：

```sh
claude
```

退出方法：输入 `/exit` 后回车

### 准备工作：去除国内用户限制

安装完 claude 后，在使用前需要编辑配置文件去掉 claude 对于国内用户的限制：

- 如果安装了cc-switch，左上角打开设置，「窗口行为」激活「跳过 Claude Code 初次安装确认」

- 手动配置

  编辑或创建 `~/.claude.json`（windows 为 `用户目录/.claude.json`），填入以下内容：

  ```json
  {
    "hasCompletedOnboarding": true
  }
  ```

  > 提示：这个配置文件的其他自动基本上都是自动生成的非重要内容，可以直接覆盖。

## 2. 配置 API Key

国内用户一般无法直接使用 claude-code 的服务，通常需要使用第三方 AI 服务，如 MiniMax、GLM、kimi、deepseek 等。

如果需要使用第三方服务，在购买服务之后，根据 API 接入文档配置服务，下面给出通用的过程。

> 如果你购买了 claude 官方的服务，且网络环境支持访问官方服务，只要运行 `claude` 命令后 > 输入 `/login` 登录即可。

### （推荐）使用 cc-switch 管理配置

打开 cc-switch 软件 > 点击右上角加号 > 选择对应的提供商 > 填入「API Key」，按需求调整设置 > 然后点击右下角「添加」 > 主界面选择「启用」服务

cc-switch的推荐设置（点击左上角齿轮图标进入设置）：

- 「通用 > Skills 存储位置」选择 `~/.agents/skills`
- 「通用 > Skills 同步方式」选择“软链接”
- 「通用 > 窗口行为 > 应用到 Claude Code 插件」选择启用
- 「通用 > 窗口行为 > 跳过 Claude Code 初次安装确认」选择启用

cc-switch支持 WebDAV 云同步，方便多设备同步配置。在设置「高级」页面里可以设置云同步配置，推荐使用[坚果云](https://help.jianguoyun.com/?p=2064)。

### 手动配置

如果想要手动配置 API key，有两种方式：修改配置文件、设置环境变量。

> 每种配置方式本质上都是设置环境变量，用其中一种方式即可，具体需要设置哪些环境变量请参考文档。

首先需要确保清除以下 Anthropic 相关的环境变量，以免影响其他 API 的正常使用：

```sh
unset ANTHROPIC_AUTH_TOKEN
unset ANTHROPIC_BASE_URL
```

> 环境变量 `ANTHROPIC_AUTH_TOKEN` 和 `ANTHROPIC_BASE_URL` 优先级高于配置文件

#### 方式一：修改配置文件

相应的配置文件是 `~/.claude/settings.json`（windows 是 `用户目录/.claude/settings.json`）。

以 [MiniMax](https://platform.minimaxi.com/docs/guides/text-ai-coding-tools#手动编辑配置文件) 为例，添加或修改 `env` 字段的内容：

```json
{
  # `YOUR_API_KEY` 需替换成你的 API Key
  # 环境变量 `ANTHROPIC_AUTH_TOKEN` 和 `ANTHROPIC_BASE_URL` 优先级高于配置文件
  "env": {
    "ANTHROPIC_BASE_URL": "https://api.minimaxi.com/anthropic",
    "ANTHROPIC_AUTH_TOKEN": "YOUR_API_KEY",
    "API_TIMEOUT_MS": "3000000",
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": "1",
    "ANTHROPIC_MODEL": "MiniMax-M2.7",
    "ANTHROPIC_DEFAULT_SONNET_MODEL": "MiniMax-M2.7",
    "ANTHROPIC_DEFAULT_OPUS_MODEL": "MiniMax-M2.7",
    "ANTHROPIC_DEFAULT_HAIKU_MODEL": "MiniMax-M2.7"
  }
}
```

配置完成后，进入工作目录，在终端中运行 `claude` 命令以启动 Claude Code

#### 方式二：设置环境变量

前一种方式的等价 bash/zsh 命令：

```sh
# 必须设置
# `YOUR_API_KEY` 需换成你的 API Key
export ANTHROPIC_BASE_URL="https://api.minimaxi.com/anthropic"
export ANTHROPIC_AUTH_TOKEN="YOUR_API_KEY"
# 指定模型（有些不需要）
export ANTHROPIC_MODEL="MiniMax-M2.7"
export ANTHROPIC_DEFAULT_SONNET_MODEL="MiniMax-M2.7"
export ANTHROPIC_DEFAULT_OPUS_MODEL="MiniMax-M2.7"
export ANTHROPIC_DEFAULT_HAIKU_MODEL="MiniMax-M2.7"
# 其他设置（非必须）
export API_TIMEOUT_MS="3000000"
export CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC="1"
```

可以将以上命令保存到 shell 配置文件（`~/.bashrc`、`~/.zshrc` 等）中。设置相应的环境变量后，重启终端，运行 `claude` 命令。

## 3. 在 IDE 中使用

### vscode

安装 `Claude Code for VS Code` 插件，如果安装了 `claude-code` 命令行可以直接使用。

推荐设置：

```json
{
  "claudeCode.autosave": false,
  "claudeCode.useCtrlEnterToSend": true,
  "claudeCode.preferredLocation": "sidebar"
}
```

### neovim

如果用的是 `lazyvim` 的配置，输入 `:LazyExtras` 命令，安装 `ai.claudecode` 插件（按 `x` 安装/卸载）。

### Zed

Zed 支持以 ACP 协议将 Agent 命令行工具集成到编辑器中。

`ctrl-?`打开 Agent 面板 > 面板左上角选择「Add More Agents」> 安装 `Claude Agent`

> 目前在 zed 的 agent 面板中使用 claude 的体验一般，推荐还是在命令行使用

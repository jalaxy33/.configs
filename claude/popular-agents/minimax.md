# MiniMax 配置

参考文档：[在Claude Code里使用 MiniMax](https://platform.minimaxi.com/docs/token-plan/claude-code)

👉 是否有 coding plan：是

## 1. 配置 API key

### （推荐）用cc-switch管理配置

cc-switch的 Claude 主界面 > 右上角选择加号 > 提供商选择 `MiniMax` > 填写「API Key」，指定模型 > 右下角「添加」 > 主界面选择「启用」。

### 手动配置

首先需要确保清除以下 Anthropic 相关的环境变量，以免影响其他 API 的正常使用：

```sh
unset ANTHROPIC_AUTH_TOKEN
unset ANTHROPIC_BASE_URL
```

> 每种配置方式本质上都是设置环境变量，用其中一种方式即可，具体需要设置哪些环境变量请参考文档。

#### 方式一：修改配置文件

编辑配置文件 `~/.claude/settings.json`（windows 是 `用户目录/.claude/settings.json`），添加或修改 `env` 字段的内容：

```json
{
  # `YOUR_API_KEY` 需替换成你的 API Key
  # 环境变量 `ANTHROPIC_AUTH_TOKEN` 和 `ANTHROPIC_BASE_URL` 优先级高于配置文件
  "env": {
    "ANTHROPIC_BASE_URL": "https://api.minimaxi.com/anthropic",
    "ANTHROPIC_AUTH_TOKEN": "YOUR_API_KEY",
    "ANTHROPIC_MODEL": "MiniMax-M2.7",
    "ANTHROPIC_DEFAULT_SONNET_MODEL": "MiniMax-M2.7",
    "ANTHROPIC_DEFAULT_OPUS_MODEL": "MiniMax-M2.7",
    "ANTHROPIC_DEFAULT_HAIKU_MODEL": "MiniMax-M2.7"
    "API_TIMEOUT_MS": "3000000",
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": "1",
  }
}
```

#### 方式二：设置环境变量

前一种方式的等价 bash/zsh 命令：

```sh
# `YOUR_API_KEY` 需换成你的 API Key
export ANTHROPIC_BASE_URL="https://api.minimaxi.com/anthropic"
export ANTHROPIC_AUTH_TOKEN="YOUR_API_KEY"
export ANTHROPIC_MODEL="MiniMax-M2.7"
export ANTHROPIC_DEFAULT_SONNET_MODEL="MiniMax-M2.7"
export ANTHROPIC_DEFAULT_OPUS_MODEL="MiniMax-M2.7"
export ANTHROPIC_DEFAULT_HAIKU_MODEL="MiniMax-M2.7"
export API_TIMEOUT_MS="3000000"
export CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC="1"
```

## 2. 配置 MCP 服务器（可选）

如果购买了 MiniMax 的 [Token Plan](https://platform.minimaxi.com/docs/token-plan/intro)，可以使用他们提供的 MCP 服务。详情请参考[官方文档](https://platform.minimaxi.com/docs/token-plan/mcp-guide)

提供了两个专属工具：**网络搜索** 和 **图片理解**，帮助开发者在编码过程中快速获取信息和理解图片内容。

👉 **前提条件**：1. 订阅 [Token Plan](https://platform.minimaxi.com/docs/token-plan/intro)，2. 安装 [`uv`](https://docs.astral.sh/uv/)

👉 验证方法：配置好后重新运行 `claude` > 对话框输入 `/mcp` 查看是否生效

> 官方推荐用 [MiniMax CLI](https://platform.minimaxi.com/docs/token-plan/minimax-cli) + [skills](https://github.com/MiniMax-AI/cli) 的方式替代 MCP，配置更简单、使用更加高效。

### 方式一：用cc-switch添加

点击 cc-switch 右上角添加MCP服务器。

将下面的 `MINIMAX_API_KEY` 字段换成自己的 Token Plan Key。

```json
{
  "MiniMax": {
    "command": "uvx",
    "args": ["minimax-coding-plan-mcp", "-y"],
    "env": {
      "MINIMAX_API_KEY": "MINIMAX_API_KEY",
      "MINIMAX_API_HOST": "https://api.minimaxi.com"
    }
  }
}
```

右下角「添加」保存 > MCP管理页面为 claude 启用相应 MCP 服务器

### 方式二：命令行一键添加

先设置以下环境变量：

```sh
# bash/zsh
export MINIMAX_API_KEY="your_api_key"

# fish
set -x MINIMAX_API_KEY "your_api_key"
```

然后执行下面的命令（需要先安装配置好 `claude`）：

```sh
claude mcp add -s user MiniMax --env MINIMAX_API_KEY=$MINIMAX_API_KEY --env MINIMAX_API_HOST=https://api.minimaxi.com -- uvx minimax-coding-plan-mcp -y
```

### 方式三：编辑配置文件

以上方式本质上都是在修改 `~/.claude.json` 中的 `mcpServers` 字段，即：

```json
{
  # 修改 `MINIMAX_API_KEY` 字段值为自己的 API Key
  "mcpServers": {
    "MiniMax": {
      "command": "uvx",
      "args": ["minimax-coding-plan-mcp", "-y"],
      "env": {
        "MINIMAX_API_KEY": "MINIMAX_API_KEY",
        "MINIMAX_API_HOST": "https://api.minimaxi.com"
      }
    }
  }
}
```

# deepseek 配置

参考文档：[将 deepseek 接入 Claude Code](https://api-docs.deepseek.com/zh-cn/quick_start/agent_integrations/claude_code)

👉 是否有 coding plan：否

## 配置 API key

### （推荐）用cc-switch管理配置

cc-switch的 Claude 主界面 > 右上角选择加号 > 提供商选择 `DeepSeek` > 填写「API Key」，指定模型 > 右下角「添加」 > 主界面选择「启用」。

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
    "ANTHROPIC_BASE_URL": "https://api.moonshot.cn/anthropic",
    "ANTHROPIC_AUTH_TOKEN": "YOUR_API_KEY",
    "ANTHROPIC_DEFAULT_HAIKU_MODEL": "deepseek-v4-flash",
    "ANTHROPIC_DEFAULT_OPUS_MODEL": "deepseek-v4-pro",
    "ANTHROPIC_DEFAULT_SONNET_MODEL": "deepseek-v4-pro",
    "ANTHROPIC_MODEL": "deepseek-v4-pro[1m]",
    "ANTHROPIC_REASONING_MODEL": "deepseek-v4-pro",
    "CLAUDE_CODE_SUBAGENT_MODEL": "deepseek-v4-flash",
    "CLAUDE_CODE_EFFORT_LEVEL": "max"
  }
}
```

#### 方式二：设置环境变量

前一种方式的等价 bash/zsh 命令：

```sh
# `YOUR_API_KEY` 需换成你的 API Key
export ANTHROPIC_BASE_URL=https://api.deepseek.com/anthropic
export ANTHROPIC_AUTH_TOKEN=YOUR_API_KEY
export ANTHROPIC_MODEL=deepseek-v4-pro[1m]
export ANTHROPIC_DEFAULT_OPUS_MODEL=deepseek-v4-pro[1m]
export ANTHROPIC_DEFAULT_SONNET_MODEL=deepseek-v4-pro[1m]
export ANTHROPIC_DEFAULT_HAIKU_MODEL=deepseek-v4-flash
export CLAUDE_CODE_SUBAGENT_MODEL=deepseek-v4-flash
export CLAUDE_CODE_EFFORT_LEVEL=max
```

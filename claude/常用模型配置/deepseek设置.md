# Deepseek 设置

模型名称：`deepseek-v4-pro`、`deepseek-v4-flash`

接入文档：<https://api-docs.deepseek.com/zh-cn/guides/anthropic_api>

## 模型配置

Claude Code 环境变量 `~/.claude/settings.json`：

**注：请将 `"ANTHROPIC_AUTH_TOKEN"` 字段更换为自己的 API key**。

```json
{
  "env": {
    "ANTHROPIC_BASE_URL": "https://api.deepseek.com/anthropic",
    "ANTHROPIC_AUTH_TOKEN": "<YOUR_API_KEY>",
    "ANTHROPIC_MODEL": "deepseek-v4-pro[1m]",
    "ANTHROPIC_DEFAULT_SONNET_MODEL": "deepseek-v4-pro",
    "ANTHROPIC_DEFAULT_OPUS_MODEL": "deepseek-v4-pro",
    "ANTHROPIC_DEFAULT_HAIKU_MODEL": "deepseek-v4-flash",
    "CLAUDE_CODE_SUBAGENT_MODEL": "deepseek-v4-pro",
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": 1,
    "CLAUDE_CODE_DISABLE_NONSTREAMING_FALLBACK": 1,
    "CLAUDE_CODE_EFFORT_LEVEL": "max"
  }
}
```

## vscode 设置

- 如果装了命令行工具，**保持默认就行**，也可以手动指定：

  ```json
  {
    "claude-code.selectedModel": "deepseek-v4-pro"
  }
  ```

- 如果没装命令行工具：

  **注：请将 `"ANTHROPIC_AUTH_TOKEN"` 字段更换为自己的 API key**。

  ```json
  {
    "claudeCode.environmentVariables": [
      {
        "name": "ANTHROPIC_BASE_URL",
        "value": "https://open.bigmodel.cn/api/anthropic"
      },
      {
        "name": "ANTHROPIC_AUTH_TOKEN",
        "value": "<YOUR_API_KEY>"
      },
      {
        "name": "ANTHROPIC_MODEL",
        "value": "deepseek-v4-pro[1m]"
      },
      {
        "name": "ANTHROPIC_DEFAULT_SONNET_MODEL",
        "value": "deepseek-v4-pro"
      },
      {
        "name": "ANTHROPIC_DEFAULT_OPUS_MODEL",
        "value": "deepseek-v4-pro"
      },
      {
        "name": "ANTHROPIC_DEFAULT_HAIKU_MODEL",
        "value": "deepseek-v4-flash"
      },
      {
        "name": "CLAUDE_CODE_SUBAGENT_MODEL",
        "value": "deepseek-v4-pro"
      },
      {
        "name": "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC",
        "value": "1"
      },
      {
        "name": "CLAUDE_CODE_DISABLE_NONSTREAMING_FALLBACK",
        "value": "1"
      },
      {
        "name": "CLAUDE_CODE_EFFORT_LEVEL",
        "value": "max"
      }
    ]
  }
  ```

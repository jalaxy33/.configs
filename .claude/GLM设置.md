
模型名称：`GLM-4.7`

- Claude Code 环境变量 `~/.claude/settings.json`：
  ```json
  "env": {
    "ANTHROPIC_BASE_URL": "https://open.bigmodel.cn/api/anthropic",
    "ANTHROPIC_AUTH_TOKEN": "<YOUR_API_KEY>",
    "API_TIMEOUT_MS": "3000000",
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": 1,
    "ANTHROPIC_MODEL": "glm-4.7",
    "ANTHROPIC_SMALL_FAST_MODEL": "glm-4.7",
    "ANTHROPIC_DEFAULT_SONNET_MODEL": "glm-4.7",
    "ANTHROPIC_DEFAULT_OPUS_MODEL": "glm-4.7",
    "ANTHROPIC_DEFAULT_HAIKU_MODEL": "glm-4.5-air"
  }
  ```

- vscode 设置：
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
              "name": "API_TIMEOUT_MS",
              "value": "3000000"
          },
          {
              "name": "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC",
              "value": "1"
          },
          {
              "name": "ANTHROPIC_MODEL",
              "value": "glm-4.7"
          },
          {
              "name": "ANTHROPIC_SMALL_FAST_MODEL",
              "value": "glm-4.7"
          },
          {
              "name": "ANTHROPIC_DEFAULT_SONNET_MODEL",
              "value": "glm-4.7"
          },
          {
              "name": "ANTHROPIC_DEFAULT_OPUS_MODEL",
              "value": "glm-4.7"
          },
          {
              "name": "ANTHROPIC_DEFAULT_HAIKU_MODEL",
              "value": "glm-4.5-air"
          }
      ],
  }
  ``` 

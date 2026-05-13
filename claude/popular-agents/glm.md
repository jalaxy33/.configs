# GLM 配置

参考文档：

- [在 Claude Code 中使用 GLM](https://docs.bigmodel.cn/cn/coding-plan/tool/claude)
- [GLM 编码套餐接入指南](https://docs.bigmodel.cn/cn/coding-plan/quick-start#claude-code)

👉 是否有 coding plan：是（但难抢）

## 1. 配置 API key

### （推荐）用cc-switch管理配置

cc-switch的 Claude 主界面 > 右上角选择加号 > 提供商选择 `Zhipu GLM` > 填写「API Key」，指定模型 > 右下角「添加」 > 主界面选择「启用」。

> 注意，GLM有些模型需要订阅 coding plan 套餐，这里需按实际情况来。可以在填完 API Key 后，点击「获取模型列表」后选择可用的模型。

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
    "ANTHROPIC_BASE_URL": "https://open.bigmodel.cn/api/anthropic",
    "ANTHROPIC_AUTH_TOKEN": "YOUR_API_KEY",
    "ANTHROPIC_DEFAULT_HAIKU_MODEL": "GLM-5.1",
    "ANTHROPIC_DEFAULT_OPUS_MODEL": "GLM-5.1",
    "ANTHROPIC_DEFAULT_SONNET_MODEL": "GLM-5.1",
    "ANTHROPIC_MODEL": "GLM-5.1",
    "API_TIMEOUT_MS": "3000000",
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": "1",
  }
}
```

#### 方式二：设置环境变量

前一种方式的等价 bash/zsh 命令：

```sh
# `YOUR_API_KEY` 需换成你的 API Key
export ANTHROPIC_BASE_URL="https://open.bigmodel.cn/api/anthropic"
export ANTHROPIC_AUTH_TOKEN="YOUR_API_KEY"
export ANTHROPIC_MODEL="GLM-5.1"
export ANTHROPIC_DEFAULT_SONNET_MODEL="GLM-5.1"
export ANTHROPIC_DEFAULT_OPUS_MODEL="GLM-5.1"
export ANTHROPIC_DEFAULT_HAIKU_MODEL="GLM-5.1"
export API_TIMEOUT_MS="3000000"
export CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC="1"
```

## 2. 配置 MCP 服务器（可选）

如果购买了 GLM 的 [Coding Plan](https://docs.bigmodel.cn/cn/coding-plan/overview)，可以使用他们提供的 MCP 服务。详情请参考[官方文档](https://docs.bigmodel.cn/cn/coding-plan/mcp/vision-mcp-server)

提供了四个专属工具：

- [视觉理解](https://docs.bigmodel.cn/cn/coding-plan/mcp/vision-mcp-server)
- [联网搜索](https://docs.bigmodel.cn/cn/coding-plan/mcp/search-mcp-server)
- [网页读取](https://docs.bigmodel.cn/cn/coding-plan/mcp/reader-mcp-server)
- [开源仓库](https://docs.bigmodel.cn/cn/coding-plan/mcp/zread-mcp-server)

👉 **前提条件**：1. 订阅 [Coding Plan](https://docs.bigmodel.cn/cn/coding-plan/overview)，2. 安装 Node.js 和 npm

👉 验证方法：配置好后重新运行 `claude` > 对话框输入 `/mcp` 查看是否生效

### 方式一：用cc-switch添加

点击 cc-switch 右上角添加MCP服务器。

将下面的 `Z_AI_API_KEY` 字段换成自己的 API Key。

- GLM视觉理解

  ```json
  {
    "glm-zai-mcp-server": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@z_ai/mcp-server"],
      "env": {
        "Z_AI_API_KEY": "Z_AI_API_KEY",
        "Z_AI_MODE": "ZHIPU"
      }
    }
  }
  ```

- GLM联网搜索

  ```json
  {
    "glm-web-search-prime": {
      "type": "http",
      "url": "https://open.bigmodel.cn/api/mcp/web_search_prime/mcp",
      "headers": {
        "Authorization": "Bearer Z_AI_API_KEY"
      }
    }
  }
  ```

- GLM网页读取

  ```json
  {
    "glm-web-reader": {
      "type": "http",
      "url": "https://open.bigmodel.cn/api/mcp/web_reader/mcp",
      "headers": {
        "Authorization": "Bearer Z_AI_API_KEY"
      }
    }
  }
  ```

- GLM开源仓库

  ```json
  {
    "glm-zread": {
      "type": "http",
      "url": "https://open.bigmodel.cn/api/mcp/zread/mcp",
      "headers": {
        "Authorization": "Bearer Z_AI_API_KEY"
      }
    }
  }
  ```

右下角「添加」保存 > MCP管理页面为 claude 启用相应 MCP 服务器

### 方式二：命令行一键添加

先设置以下环境变量：

```sh
# bash/zsh
export Z_AI_API_KEY="your_api_key"

# fish
set -x Z_AI_API_KEY "your_api_key"
```

然后执行下面的命令（需要先安装配置好 `claude`）：

```sh
# 视觉理解
claude mcp add -s user glm-zai-mcp-server --env Z_AI_API_KEY=$Z_AI_API_KEY -- npx -y "@z_ai/mcp-server"
# 联网搜索
claude mcp add -s user -t http glm-web-search-prime https://open.bigmodel.cn/api/mcp/web_search_prime/mcp --header "Authorization: Bearer $Z_AI_API_KEY"
# 网页读取
claude mcp add -s user -t http glm-web-reader https://open.bigmodel.cn/api/mcp/web_reader/mcp --header "Authorization: Bearer $Z_AI_API_KEY"
# 开源仓库
claude mcp add -s user -t http glm-zread https://open.bigmodel.cn/api/mcp/zread/mcp --header "Authorization: Bearer $Z_AI_API_KEY"
```

### 方式三：编辑配置文件

以上方式本质上都是在修改 `~/.claude.json` 中的 `mcpServers` 字段，即：

```json
{
  # 修改 `Z_AI_API_KEY` 字段值为自己的 API Key
  "mcpServers": {
    "glm-zai-mcp-server": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@z_ai/mcp-server"],
      "env": {
        "Z_AI_API_KEY": "Z_AI_API_KEY",
        "Z_AI_MODE": "ZHIPU"
      }
    },
    "glm-web-search-prime": {
      "type": "http",
      "url": "https://open.bigmodel.cn/api/mcp/web_search_prime/mcp",
      "headers": {
        "Authorization": "Bearer Z_AI_API_KEY"
      }
    },
    "glm-web-reader": {
      "type": "http",
      "url": "https://open.bigmodel.cn/api/mcp/web_reader/mcp",
      "headers": {
        "Authorization": "Bearer Z_AI_API_KEY"
      }
    },
    "glm-zread": {
      "type": "http",
      "url": "https://open.bigmodel.cn/api/mcp/zread/mcp",
      "headers": {
        "Authorization": "Bearer Z_AI_API_KEY"
      }
    }
  }
}
```

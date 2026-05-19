# pi安装配置指南

[`pi`](https://pi.dev/) 是类似于 `claude-code` 的 agent cli 工具，特点是简洁，默认的 system prompt 极少，且可以方便的扩展。

## 安装

安装前请确保已经安装了 Node.js 和 npm。

安装命令：

```sh
# npm安装
npm install -g @mariozechner/pi-coding-agent

# pnpm安装
pnpm add -g @earendil-works/pi-coding-agent

# bun安装
bun add -g @earendil-works/pi-coding-agent
```

然后使用 `pi` 启动 cli 工具。

## 配置 API 提供商

### 方式一：编辑配置文件

在 `~/.pi/agent/auth.json` 中配置 API 提供商的密钥，可以同时配置多个提供商，参考 [docs/providers.md](https://github.com/badlogic/pi-mono/blob/main/packages/coding-agent/docs/providers.md) 文档。

下面是配置 GLM、MiniMax 和 kimi 的 coding plan 的示例：

```json
{
  "zai": { "type": "api_key", "key": "..." },
  "minimax-cn": { "type": "api_key", "key": "sk-cp-..." },
  "kimi-coding": { "type": "api_key", "key": "sk-kimi-..." }
}
```

配置好之后，重启 `pi` 使用 `/model` 选择模型即可。

### 方式二：环境变量

参考 [docs/providers.md](https://github.com/badlogic/pi-mono/blob/main/packages/coding-agent/docs/providers.md) 文档，设置相应的环境变量，重启终端和 `pi`，使用 `/model` 选择模型即可。

以下是一些例子：

- bash/zsh:

  ```sh
  # GLM
  export ZAI_API_KEY="..."
  # minimax-cn
  export MINIMAX_CN_API_KEY="sk-cp-..."
  # kimi-coding
  export KIMI_API_KEY="sk-cp-..."
  ```

- fish：

  ```sh
  set -x ZAI_API_KEY "..."
  set -x MINIMAX_CN_API_KEY "sk-cp-..."
  set -x KIMI_API_KEY "sk-cp-..."
  ```

## 使用skills

pi 能自动识别 `.agents/skills` 目录下的 skills。

如果同时使用 claude，建议将 skills 统一放在 `~/.agents/skills/` 目录下，然后软链接到 `~/.claude/skills/` 中。

> 这个操作可以在 cc-switch 设置：「设置」>「通用」> 「Skills存储位置」

## 安装扩展

`pi` 是极简的 agent cli 工具，只提供最简单的功能。但是扩展性极强，可以在[扩展商店](https://pi.dev/packages)里查看可用的扩展以及对应的安装方式。

常用命令：

```sh
# 安装扩展
pi install <extension-name>

# 卸载扩展
pi uninstall <extension-name>
```

我在用的一些扩展：

- [`pi-subagents`](https://pi.dev/packages/pi-subagents)：创建subagent
- [`pi-mcp-adapter`](https://pi.dev/packages/pi-mcp-adapter)：MCP适配器
- [`pi-permission-layers`](https://pi.dev/packages/pi-permission-layers)：pi本身没有权限管理，默认允许一切操作。这个插件提供了类似于claude的权限管理功能。
- [`context-mode`](https://pi.dev/packages/context-mode): 节约上下文
- [`@juicesharp/rpiv-ask-user-question`](https://pi.dev/packages/@juicesharp/rpiv-ask-user-question)：向用户询问具体细节
- [`@juicesharp/rpiv-todo`](https://pi.dev/packages/@juicesharp/rpiv-todo)：todo 列表渲染
- [`@juicesharp/rpiv-btw`](https://pi.dev/packages/@juicesharp/rpiv-btw): 提供 `/btw` 命令

有用但是不太好用的扩展：
- [`@plannotator/pi-extension`](https://pi.dev/packages/@plannotator/pi-extension)：计划模式
- [`pi-web-access`](https://pi.dev/packages/pi-web-access)：联网搜索


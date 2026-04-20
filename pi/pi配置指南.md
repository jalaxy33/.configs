# pi安装配置指南

`pi` 是类似于 `claude-code` 的 agent cli 工具，特点是简洁，默认的 system prompt 极少，且可以方便的扩展。

## 安装

使用 npm 安装：

```sh
npm install -g @mariozechner/pi-coding-agent
```

然后使用 `pi` 启动 cli 工具。

## 配置 API 提供商

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

# MCP服务器推荐

MCP（模型上下文协议，Model Context Protocol）是 Anthropic 推出的开放标准，MCP 为 Agent 提供了一种访问外部工具的方便接口，如联网搜索等，赋予了 Agent 更强大的能力。

MCP 的缺点在于其上下文占用较高，目前有很多服务开始转向以 「cli + skills」的形式提供。

除了各个 API 提供商提供的 MCP 服务外，我现在会用的 MCP 服务：

- [context7](https://github.com/upstash/context7/blob/master/README.md)：文档搜索工具，提供最新的库文档和代码示例，配置 key 会有更高限额。可以用 [`ctx7`](https://context7.com/docs/clients/cli) cli+skill 替代
- [deepwiki](https://docs.devin.ai/work-with-devin/deepwiki-mcp)：AI解读 github 仓库，可以用 [deepwiki](https://www.deepwiki.sh/) cli+skill 替代

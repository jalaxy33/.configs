# skills推荐

Skills 是一种可复用指令集，用来指导特定任务的执行方式。其核心设计理念是「渐进式披露」和「按需加载」，避免一次性将过多内容塞入上下文窗口。

Claude 在相关时使用 skills，或者你可以使用 `/skill-name` 直接调用一个。

一个相关的概念是 CLI 命令行工具，CLI 为 agent 和人类提供了统一的交互界面。CLI 提供外部工具接口，skills 规范了工作流程。目前，CLI+skills 的模式逐渐取代 MCP，成为主流的外部工具调用模式。利用 skills 渐进式披露的特点，规避了 MCP 上下文占用多的弊端。

一般安装方法：用 `npx skills` 命令或者 cc-switch

```sh
npx skills add https://<repo-url> --skill <skill-name>
```

skills来源：

- [skills.sh](https://www.skills.sh/)：提供 `npx skills` 的安装命令
- anthropic官方Skills仓库：[anthropics/skills](https://github.com/anthropics/skills)
- Github等平台的公有Skills仓库，文件结构中包含了`SKILL.md`

## 推荐的参考资料

- 官方文档：[skills](https://code.claude.com/docs/en/skills)
- 视频：[彻底搞懂Agent skill！从概念到实战，上手玩转skill](https://www.bilibili.com/video/BV182z5BRE4f/)
- 视频：[手把手彻底学会 Agent Skills！【小白教程】](https://www.bilibili.com/video/BV1G3FNznEiS/)
- 博客：[Agent Skills 与 MCP：智能体能力扩展的两种范式](https://github.com/datawhalechina/hello-agents/blob/main/Extra-Chapter/Extra05-AgentSkills%E8%A7%A3%E8%AF%BB.md)

## 我在用的一些skills

### OpenSpec

这是一个 CLI 工具，提供了一套规范驱动开发（SDD）的工作流，用于解决AI编程中需求混乱、输出不可控的问题。用法参考[文档](https://github.com/Fission-AI/OpenSpec)。

安装方法：

```sh
npm install -g @fission-ai/openspec@latest
```

使用方法：

1. 进入工程目录，初始化：

   ```sh
   cd your-project
   openspec init
   ```

   根据提示进行操作，选择 `claude`，之后会在项目 `.claude` 目录下创建相关的 skills。

2. 然后告诉 Agent 你的需求：

   ```sh
   /opsx:propose <what-you-want-to-build>
   ```

   之后根据提示进行操作。例如同意计划，进入实施阶段：`/opsx:approve`

### opencli

这是一个 CLI 工具，可以让网站、浏览器会话、Electron 应用和本地工具转化为人类和 agent 访问的命令行接口，agent 可以用这个工具来从 bilibili、知乎、小红书等网站获取信息。

opencli 提供了一系列 skill，使用前需要先安装 CLI 工具和浏览器插件。

1. 安装 opencli 工具

   ```sh
   npm install -g @jackwener/opencli
   ```

2. 安装浏览器插件：从 Chrome 应用商店安装 [OpenCLI](https://chromewebstore.google.com/detail/opencli/ildkmabpimmkaediidaifkhjpohdnifk) 扩展；或者直接从 Github [Release Page](https://github.com/jackwener/opencli/releases) 下载安装

3. 验证设置

   ```sh
   opencli doctor

   # 尝试运行命令
   opencli list
   opencli hackernews top --limit 5
   opencli bilibili hot --limit 5
   ```

4. 安装 skills

   ```sh
   npx skills add jackwener/opencli
   ```

   或者只安装需要的

   ```sh
   npx skills add jackwener/opencli --skill opencli-adapter-author
   npx skills add jackwener/opencli --skill opencli-autofix
   npx skills add jackwener/opencli --skill opencli-browser
   npx skills add jackwener/opencli --skill opencli-usage
   npx skills add jackwener/opencli --skill smart-search
   ```

### deepwiki

仓库地址：[deepwiki](https://github.com/seflless/deepwiki/blob/main/skills/deepwiki/SKILL.md)

AI 解读任意公开 Github 仓库。

安装方法：

```sh
npx skills add https://github.com/seflless/deepwiki --skill deepwiki
```

同时，也提供了 CLI 工具：

```sh
# 安装
npm install -g @seflless/deepwiki

# 使用
deepwiki ask facebook/react "How does the fiber reconciler work?"
deepwiki wiki oven-sh/bun
deepwiki toc facebook/react
deepwiki wiki anthropics/claude-code --json > docs.json
```

### context7

仓库地址：[context7-cli](https://github.com/upstash/context7/blob/master/skills/context7-cli/SKILL.md)

文档搜索工具，当你问关于某个库的用法时，会拉取库的最新文档来回答，[配置 key](https://context7.com/dashboard) 会有更高限额。主要用于知名的库/框架，可指定版本。

有两种使用方法：CLI + Skills 或 MCP，这里介绍前一种。

安装方法：

```sh
npx ctx7 setup

# 如果有API key
npx ctx7 setup --api-key <key>
```

安装完后会安装一个名为 `find-docs` 的 skills，并添加 context7 MCP。

### find-skills

仓库地址：[find-skills](https://github.com/vercel-labs/skills/blob/HEAD/skills/find-skills/SKILL.md)

搜索并安装 skills

安装方法：

```sh
npx skills add https://github.com/vercel-labs/skills --skill find-skills
```

相关的 CLI 工具：

```sh
npx skills find [query]     # Search for skills interactively or by keyword
npx skills add <package>    # Install a skill from GitHub or other sources
npx skills check            # Check for skill updates
npx skills update           # Update all installed skills
```

### skill-creator

仓库地址：[skill-creator](https://github.com/anthropics/skills/blob/main/skills/skill-creator/SKILL.md)

Anthropic 的官方 skill，用于创建新的 skills。

安装方法：

```sh
npx skills add https://github.com/anthropics/skills --skill skill-creator
```

### mmx-cli

仓库地址：[mmx-cli](https://github.com/MiniMax-AI/cli/blob/main/skill/SKILL.md)

这是 MiniMax 的 CLI 命令行工具和 skills，如果订阅了 token plan 可以使用，可以用来替代他们的 MCP 服务。

提供了以下能力：

- 图像理解
- 网络搜索
- 生成：文本对话、图像生成、视频生成、语音合成、音乐生成

skill 安装方法：

```sh
npx skills add MiniMax-AI/cli -y -g
```

也可以安装 cli 工具：

```sh
# 安装
npm install -g mmx-cli

# 登录验证
mmx auth login
# Or
mmx auth login --api-key sk-xxxxx

# 使用方法
mmx vision photo.jpg    # 图像理解
mmx search "MiniMax AI latest news"   # 联网搜索
mmx text chat --message "What is MiniMax?"
mmx image "A cat in a spacesuit"
mmx speech synthesize --text "Hello!" --out hello.mp3
mmx video generate --prompt "Ocean waves at sunset"
mmx music generate --prompt "Upbeat pop" --lyrics "[verse] La da dee, sunny day"
mmx quota
```

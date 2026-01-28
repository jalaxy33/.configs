
## 全局设置

- 设置代理（将7890换成自己的端口）
  ```sh
  git config --global http.proxy http://127.0.0.1:7890
  git config --global https.proxy http://127.0.0.1:7890
  ```

- 取消代理

  ```sh
  git config --global --unset http.proxy
  git config --global --unset https.proxy
  ```

- 新项目自动设置push分支
  ```sh
  git config --global push.autoSetupRemote true
  ```

- 设置免验证push/pull（只需要验证一次）
  ```sh
  git config --global credential.helper store
  ```

- 设置默认分支为main

  ```sh
  git config --global init.defaultBranch main
  ```


## 项目设置

- 新项目设置用户名和邮箱（第一次commit前）
  ```sh
  git config user.name "Your Name"
  ```
  ```sh
  git config user.email "you@example.com"
  ```

- 修改当前项目的分支为main

  ```sh
  git branch -M main
  ```


## 常用命令

### 分支管理

- 查看本地所有分支
  ```sh
  git branch
  ```

- 切换分支
  ```sh
  git checkout <分支名>
  ```

- 创建并切换到新分支：
  ```sh
  git checkout -b <分支名>
  ```

- 合并分支：将其他分支的提交合并至本分支
  ```sh
  git merge <其他分支名>
  ```

- 删除分支：
  ```sh
  git branch -d <分支名>
  ```


## 规范

- [Commit格式规范](https://doris.apache.org/zh-CN/community/how-to-contribute/commit-format-specification)
- 提交类型：
  - fix：bug 修复
  - feature：新增功能
  - feature-wip：开发中的功能，比如某功能的部分代码。
  - improvement：原有功能的优化和改进
  - style：代码风格调整
  - typo：代码或文档勘误
  - refactor：代码重构（不涉及功能变动）
  - performance/optimize：性能优化
  - test：单元测试的添加或修复
  - chore：构建工具的修改
  - revert：回滚
  - deps：第三方依赖库的修改
  - community：社区相关的修改，如修改 Github Issue 模板等。


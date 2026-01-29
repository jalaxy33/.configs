
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

- [Commit message 和 Change log 编写指南](https://www.ruanyifeng.com/blog/2016/01/commit_message_change_log.html)
- [Commit格式规范](https://doris.apache.org/zh-CN/community/how-to-contribute/commit-format-specification)


## 遇到过的问题

### 修改历史commits中的用户名和邮箱

1. 在项目目录下创建一个脚本，下面是Linux/Mac下的例子：
    ```sh
    #!/bin/sh
    git filter-branch --env-filter '
    OLD_EMAIL="原来的邮箱"
    CORRECT_NAME="现在的名字"
    CORRECT_EMAIL="现在的邮箱"
    if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
    then
        export GIT_COMMITTER_NAME="$CORRECT_NAME"
        export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
    fi
    if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
    then
        export GIT_AUTHOR_NAME="$CORRECT_NAME"
        export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
    fi
    ' --tag-name-filter cat -- --branches --tags
    ```

2. 然后用 `chmod +x <脚本名>.sh` 赋予执行权限后运行脚本，或者直接用 bash 运行这个脚本。
    
    > 如果运行失败，先执行下面的命令：
    > ```sh
    > git filter-branch -f --index-filter 'git rm --cached --ignore-unmatch Rakefile' HEAD
    > ```
    > 然后再尝试执行

3. 执行完成后，查看 `git log` 可以看到已经修改成功。
4. 如果要推送到远程：
    ```sh
    git push origin --force --all
    ```
    去看一下 Github 你就会发现之前的提交记录中，name 和 email 信息都更新了。







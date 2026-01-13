
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

## 项目设置

- 新项目设置用户名和邮箱（第一次commit前）
  ```sh
  git config user.name "Your Name"
  ```
  ```sh
  git config user.email "you@example.com"
  ```


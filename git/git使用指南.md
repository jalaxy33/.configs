
- 设置代理（将7890换成自己的端口）
  ```sh
  git config --global http.proxy http://127.0.0.1:7890
  git config --global https.proxy http://127.0.0.1:7890
  ```

- 新项目自动设置push分支
  ```sh
  git config --global push.autoSetupRemote true
  ```

- 新项目设置用户名和邮箱（第一次commit前）
  ```sh
  git config user.email "you@example.com"
  ```
  ```sh
  git config user.name "Your Name"
  ```

- 设置免验证push/pull（只需要验证一次）
  ```sh
  git config credential.helper store
  ```



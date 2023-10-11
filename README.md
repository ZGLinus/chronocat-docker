# chronocat-docker

- 这里是 arm64 版的 chronocat
- 使用 ubuntu22.04 + openbox + linuxqq 制作
- 使用 noVNC 转发 VNC，转发容器6081端口后，可以在浏览器内完成登录，登陆地址为 `IP:Port/vnc.html`
- 如果对 amd64 版数据完全固化，不重建容器的镜像感兴趣，欢迎到 [78907d](https://github.com/ZGLinus/chronocat-docker/tree/78907d5e81f2bd74105dff35a511c1e93e27e2bf) 查看

## 使用

修改docker-compose.yml的配置

```bash
docker-compose up
```

或者使用docker-cli

```bash
docker run -itd \
	--name chronocat-docker \
	-p 5900:5900 \ # vnc端口
	-p 6081:6081 \ # noVNC端口
	-p 16530:16530 \ # chronocat端口
	-e TZ=Asia/Shanghai \
	-e VNC_PASSWD=abc \ # VNC密码（可选）
	-v $PWD/qq/config:/home/user/.config/QQ \ #数据固化
	--restart always \ 重启策略（可选）
	zglinus/chronocat-docker:3.1.2-13107
```

### VNC登陆

使用VNC软件登陆 `服务器IP:5900`，默认密码是 `vncpasswd`

### 获取RED_PROTOCOL_TOKEN

```bash
docker exec chronocat-docker cat /home/user/BetterUniverse/QQNT/RED_PROTOCOL_TOKEN
```

### 修改VNC密码

```bash
docker exec chronocat-docker sh -c "x11vnc -storepasswd newpasswd /root/.vnc/passwd"
```

或者在docker启动容器时配置环境变量 `VNC_PASSWD`

### 已知问题

- 在部分机器可能会出现 `Failed to fdwalk: Operation not permitted` 的报错，在启动命令行加上 `--security-opt=seccomp:unconfined` 或者在 `docker-compose.yaml`  加上

```yaml
    security_opt:
      - seccomp:unconfined
```

- 在部分机器会存在重启系统后登录失效的情况，尚不清楚其原理
- 可能会存在发送图片的情况，不清楚是qq本身，chronocat还是koishi的问题。

其他常见问题见原仓库中的[常见问题](https://github.com/yuuki-nya/chronocat-docker/blob/main/README.md#%E5%B7%B2%E7%9F%A5%E9%97%AE%E9%A2%98)

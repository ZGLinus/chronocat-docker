# chronocat-docker

- 这里是arm64版的chronocat
- 使用ubuntu22.04 + openbox + linuxqq 制作
- 使用noVNC转发VNC，转发容器6081端口后，可以在浏览器内完成登录，登陆地址为`IP:Port/vnc.html`

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

使用VNC软件登陆`服务器IP:5900`，默认密码是`vncpasswd`

### 获取RED_PROTOCOL_TOKEN

```bash
docker exec chronocat-docker cat /home/user/BetterUniverse/QQNT/RED_PROTOCOL_TOKEN
```

### 修改VNC密码

```bash
docker exec chronocat-docker sh -c "x11vnc -storepasswd newpasswd /root/.vnc/passwd"
```

或者在docker启动容器时配置环境变量`VNC_PASSWD`


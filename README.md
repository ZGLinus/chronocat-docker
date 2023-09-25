# chronocat-docker

使用ubuntu22.04 + openbox + linuxqq 制作
容器不需要重建，所有程序更新由主机完成，从底层排除了docker重建丢失数据的可能性

## 使用

修改docker-compose.yml的端口配置

```bash
sudo apt-get install unzip curl
sudo apt-get isntall docker-compose-plugin
sudo chmod +x scripts/*.sh
./scripts/init.sh
```

### VNC登陆

使用VNC软件登陆`服务器IP:5900`，默认密码是`vncpasswd`

### 获取RED_PROTOCOL_TOKEN

```bash
docker exec chronocat-docker cat /home/user/BetterUniverse/QQNT/RED_PROTOCOL_TOKEN
```
或者
```bash
cat data/BetterUniverse/QQNT/RED_PROTOCOL_TOKEN
```

### 修改VNC密码

```bash
docker exec chronocat-docker sh -c "x11vnc -storepasswd newpasswd /root/.vnc/passwd"
```

其中newpasswd换成你的新密码，立即生效，无需重启容器

## 已知问题

- 容器重启后，桌面的任务栏可能会消失，如果触发了请不要缩小或者点叉关闭，建议保持在聊天的界面，再关闭VNC远程
- 容器重启后，仍然需要手动点击登录，但是更新软件不需要扫码；但是仍然小概率会退出登录，目前不清楚原理
- 创建容器可能会启动失败，目前不清楚原理，删除容器多尝试几次即可



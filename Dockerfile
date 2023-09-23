# 使用基于Ubuntu 22.04的基础映像
FROM ubuntu:22.04

# 设置环境变量
ENV DEBIAN_FRONTEND=noninteractive
ENV VNC_PASSWD=vncpasswd

# 安装必要的软件包
RUN apt-get update && apt-get install -y \
    openbox \
    curl \
    unzip \
    x11vnc \
    xvfb \
    fluxbox \
    supervisor \
    libnotify4 \
    libnss3 \
    xdg-utils \
    libsecret-1-0 \
    libgbm1 \
    libasound2 \
    fonts-wqy-zenhei \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 新增用户
RUN useradd -m -s /bin/bash user && echo 'user'


# 创建必要的目录
RUN mkdir -p ~/.vnc

# 设置VNC密码
RUN x11vnc -storepasswd $VNC_PASSWD ~/.vnc/passwd

# 创建启动脚本
RUN echo "#!/bin/bash" > ~/start.sh
RUN echo "rm /tmp/.X1-lock" >> ~/start.sh
RUN echo "Xvfb :1 -screen 0 1280x1024x16 &" >> ~/start.sh
RUN echo "export DISPLAY=:1" >> ~/start.sh
RUN echo "fluxbox &" >> ~/start.sh
RUN echo "x11vnc -display :1 -noxrecord -noxfixes -noxdamage -forever -rfbauth ~/.vnc/passwd &" >> ~/start.sh
RUN echo "su -c 'qq' user" >> ~/start.sh
RUN chmod +x ~/start.sh

# 配置supervisor
RUN echo "[supervisord]" > /etc/supervisor/supervisord.conf
RUN echo "nodaemon=true" >> /etc/supervisor/supervisord.conf
RUN echo "[program:x11vnc]" >> /etc/supervisor/supervisord.conf
RUN echo "command=/usr/bin/x11vnc -display :1 -noxrecord -noxfixes -noxdamage -forever -rfbauth ~/.vnc/passwd" >> /etc/supervisor/supervisord.conf

# 设置容器启动时运行的命令
CMD ["/bin/bash", "-c", "/root/start.sh"]

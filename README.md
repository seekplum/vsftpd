# 基于官方centos6.7镜像制作的ftp服务器镜像

----------------------------

## 拉取镜像

> docker pull seekplum/vsftpd

## 启动容器

```bash
docker run -d -v /home/ftp:/home/ftp \
-p 20:20 \
-p 21:21 \
-e FTP_USER=test -e FTP_PASS=test -e PASV_ADDRESS=0.0.0.0 \
--name vsftpd \
vsftpd
```

## 进入交互式容器

> docker exec -it vsftpd bash

## 手动启动ftp服务器

* 容器后台运行

```bash
docker run -d -v /home/ftp:/home/ftp \
-p 20:20 \
-p 21:21 \
--name vsftpd
vsftpd bash
```

* 进入交互式容器

> docker exec -it vsftpd bash

* 设置环境变量

```bash
export FTP_USER=test && \
export FTP_PASS=test && \
export PASV_ADDRESS=0.0.0.0
```

* 手动部署
> /bin/sh /usr/local/vsftpd/vsftpd.sh

* 退出容器

## 测试
在安装了ftp的服务器上执行

> ftp 192.168.1.86 21  # 192.168.1.86为ftp服务器IP地址

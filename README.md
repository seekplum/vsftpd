# 基于官方centos6.7镜像制作的ftp服务器镜像

----------------------------

## 拉取镜像

> docker pull seekplum/vsftpd

## 启动容器

```bash
docker run -d -v /home/ftp:/home/ftp \
-p 20:20 \
-p 21:21 \
-p 47000-47400:47000-47400 \
-e FTP_USER=test -e FTP_PASS=test -e PASV_ADDRESS=0.0.0.0 \
-e PASV_MIN_PORT=47000 -e PASV_MAX_PORT=47400 \
--name vsftpd \
seekplum/vsftpd
```

### 参数解释
* -p: 主机和端口容器的端口映射
* FTP_USER: ftp用户名，不指定则默认值为ftp
* FTP_PASS: ftp密码, 不指定则默认值为ftp
* PASV_ADDRESS: ftp可访问地址值为127.0.0.1代表只允许本地访问，0.0.0.0代表允许其他机器远程连接，默认值为127.0.0.1
* PASV_MIN_PORT: 被动模式下最小的端口值，不指定则默认值为47000
* PASV_MAX_PORT: 被动模式下最大的端口值，不指定则默认值为47400

## 进入交互式容器

> docker exec -it seekplum/vsftpd bash

## 手动启动ftp服务器

* 容器后台运行

```bash
docker run -d -v /home/ftp:/home/ftp \
-p 20:20 \
-p 21:21 \
--name vsftpd
seekplum/vsftpd bash
```

* 进入交互式容器

> docker exec -it seekplum/vsftpd bash

* 设置环境变量

```bash
export FTP_USER=test && \
export FTP_PASS=test && \
export PASV_MIN_PORT=47000 && \
export PASV_MAX_PORT=47400 && \
export PASV_ADDRESS=0.0.0.0
```

* 手动部署
> /bin/sh /usr/local/vsftpd/vsftpd.sh

* 退出容器

## 测试
在安装了ftp的服务器上执行

> ftp 192.168.1.86 21  # 192.168.1.86为ftp服务器IP地址

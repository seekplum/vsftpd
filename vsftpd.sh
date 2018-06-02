#!/bin/bash

# 创建用户、修改目录权限
mkdir -p /home/ftp/${FTP_USER}
# useradd -d /home/ftp ftp  # 安装ftp时会创建用户
chown -R ftp:ftp /home/ftp

# 设置ftp用户无法登陆
# usermod -s /sbin/nologin ftp

# 设置用户名和密码
echo -e "${FTP_USER}\n${FTP_PASS}" > /etc/vsftpd/virtual_users.conf

# 生成虚拟数据库文件
db_load -T -t hash -f /etc/vsftpd/virtual_users.conf /etc/vsftpd/virtual_users.db

# 删除原始密码文件，不删除则在启动ftp会有警告
rm -f /etc/vsftpd/virtual_users.conf

# 修改数据库文件权限
chmod 700 /etc/vsftpd/virtual_users.db

# 在配置文件中写入地址
echo "pasv_address=${PASV_ADDRESS}" >> /etc/vsftpd/vsftpd.conf

# 创建虚拟用户主配置目录
rm -rf /etc/vsftpd/ftp_user_conf
mkdir -p /etc/vsftpd/ftp_user_conf

# 修改用户配置
(
cat <<EOF
anon_world_readable_only=NO
anon_upload_enable=YES
anon_mkdir_write_enable=YES
anon_other_write_enable=YES
anon_umask=022
local_root=/home/ftp/${FTP_USER}
EOF
) >/etc/vsftpd/ftp_user_conf/${FTP_USER}

# 设置开机启动
chkconfig --add vsftpd 2>&1 |tee -a /var/log/vsftpd/vsftpd.log
chkconfig vsftpd on 2>&1 |tee -a /var/log/vsftpd/vsftpd.log

# 启动服务
/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf  2>&1 |tee -a /var/log/vsftpd/vsftpd.log

# 增加死循环，防止脚本退出
while true
do
	sleep 1
done

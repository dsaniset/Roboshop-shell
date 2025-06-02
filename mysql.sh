source common.sh
app_name=mysql

print_heading "Installing mysql server"
dnf install mysql-server -y

print_heading "Starting mysql service"
systemctl enable mysqld
systemctl start mysqld

mysql_secure_installation --set-root-pass RoboShop@1
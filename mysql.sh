source common.sh
app_name=mysql

print_heading "Installing mysql server"
dnf install mysql-server -y &>>$log_file
status_check $?

print_heading "Starting mysql service"
systemctl enable mysqld &>>$log_file
systemctl start mysqld &>>$log_file
status_check $?

print_heading "Secure installation"
mysql_secure_installation --set-root-pass RoboShop@1 &>>$log_file
status_check $?
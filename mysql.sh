source common.sh
app_name=mysql

print_heading "Installing mysql server"
dnf install mysql-server -y &>>$log_file
status_check $?

print_heading "Starting mysql service"
systemctl enable $app_name &>>$log_file
systemctl start $app_name &>>$log_file
status_check $?

print_heading "Secure installation"
mysql_secure_installation --set-root-pass RoboShop@1 &>>$log_file
status_check $?
source common.sh
app_name=redis

print_heading "Disabling existing Redis version"
dnf module disable $app_name -y &>>$log_file
status_check $?

print_heading "Enabling required Redis version"
dnf module enable $app_name:7 -y &>>$log_file
status_check $?

print_heading "Install Redis"
dnf install $app_name -y &>>$log_file
status_check $?

print_heading "Editing Redis config"
sed -i -e 's/127.0.0.1/0.0.0.0/' -e '/protected-mode/ c protected-mode no' /etc/redis/redis.conf &>>$log_file
status_check $?

print_heading "Starting Redis application"
systemctl enable $app_name &>>$log_file
systemctl start $app_name &>>$log_file
status_check $?
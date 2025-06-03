source common.sh
app_name=rabbitmq

print_heading "Copy rabbitmq repo setup file"
cp $app_name.repo /etc/yum.repos.d/$app_name.repo &>>$log_file
status_check $?

print_heading "Install rabbitmq"
dnf install $app_name-server -y &>>$log_file
status_check $?

print_heading "Enabling rabbitmq"
systemctl enable $app_name-server &>>$log_file
systemctl start $app_name-server &>>$log_file
status_check $?

print_heading "Setting up rabbitmq"
rabbitmqctl add_user roboshop roboshop123 &>>$log_file
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$log_file
status_check $?
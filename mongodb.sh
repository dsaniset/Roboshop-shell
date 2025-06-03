source common.sh
app_name=mongo

print_heading "Copying mongodb repo file"
cp $app_name.repo /etc/yum.repos.d/$app_name.repo &>>$log_file
status_check $?

print_heading "Installing mongodb"
dnf install mongodb-org -y &>>$log_file
status_check $?

print_heading "Editing the inbound rule"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>$log_file
status_check $?

print_heading "Starting mongodb service"
systemctl enable mongod &>>$log_file
systemctl restart mongod &>>$log_file
status_check $?
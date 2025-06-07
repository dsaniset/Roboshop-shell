source common.sh
app_name="catalogue"

nodejs_setup

print_heading "Setting up mongodb setup file"
cp $script_path/mongo.repo /etc/yum.repos.d/mongo.repo &>>$log_file
status_check $?

print_heading "Installing mongodb"
dnf install mongodb-mongosh -y &>>$log_file
status_check $?

print_heading "Load master data"
mongosh --host mongodb.devops24.shop </app/db/master-data.js &>>$log_file
status_check $?

print_heading "Restarting the catalogue service"
systemctl restart $app_name &>>$log_file
status_check $?
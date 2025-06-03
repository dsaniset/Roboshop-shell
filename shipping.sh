source common.sh
app_name=shipping

print_heading "Setting up systemd service"
cp $app_name.service /etc/systemd/system/$app_name.service &>>$log_file
status_check $?

print_heading "Installing maven"
dnf install maven -y &>>$log_file
status_check $?

app_prerequisite

print_heading "Building application"
mvn clean package &>>$log_file
mv target/$app_name-1.0.jar $app_name.jar
status_check $?

print_heading "Installing mysql"
dnf install mysql -y &>>$log_file
status_check $?

print_heading "Loading SQL schemas"
for sql in schema app-user master-data
do
  mysql -h mysql.devops24.shop -uroot -pRoboShop@1 < /app/db/$sql.sql &>>$log_file
done
status_check $?
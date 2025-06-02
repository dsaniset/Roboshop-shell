source common.sh
app_name=shipping

print_heading "Setting up systemd service"
cp $app_name.service /etc/systemd/system/$app_name.service

print_heading "Installing maven"
dnf install maven -y

app_prerequisite

print_heading "Building application"
mvn clean package
mv target/$app_name-1.0.jar $app_name.jar

print_heading "Installing mysql"
dnf install mysql -y

print_heading "Loading SQL schemas"
for sql in schema app-user master-data
do
  mysql -h mysql.devops24.shop -uroot -pRoboShop@1 < /app/db/$sql.sql
done
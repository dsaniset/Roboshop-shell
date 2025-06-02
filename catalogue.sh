source common.sh
app_name="catalogue"

print_heading "Setting up and installing Mongodb"
cp mongo.repo /etc/yum.repos.d/mongo.repo
dnf install mongodb-mongosh -y
mongosh --host mongodb.devops24.shop </app/db/master-data.js

nodejs_setup
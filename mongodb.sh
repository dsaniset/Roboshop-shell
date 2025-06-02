source common.sh
app_name=mongo

print_heading "Copying mongodb repo file"
cp mongo.repo /etc/yum.repos.d/mongo.repo

print_heading "Installing mongodb"
dnf install mongodb-org -y

print_heading "Editing the inbound rule"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf

print_heading "Starting mongodb service"
systemctl enable mongod
systemctl restart mongod
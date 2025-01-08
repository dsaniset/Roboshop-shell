dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y

add roboshop

mkdir /app

curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip

cd /app

unzip /tmp/catalogue.zip

npm install

cp catalogue.service /etc/systemd/system/

systemctl daemon-reload

systemctl enable catalogue
systemctl restart catalogue

cp mongo.repo /etc/yum.repos.d/

dnf install mongodb-mongosh -y

mongosh --host MONGODB-SERVER-IPADDRESS </app/db/master-data.js
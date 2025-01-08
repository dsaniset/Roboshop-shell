dnf module diable nodejs -y
dnf module enable nodejs:20 -y
dnf module start nodejs -y

useradd roboshop

mkdir /app

curl -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart-v3.zip

cd /app

unzip /tmp/cart.zip

cd /app

npm install

cp cart.service /tmp/systemd/system/

systemctl daemon-reload

systemctl enable nodejs
systemctl start nodejs
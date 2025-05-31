dnf module diable nodejs -y
dnf module enable nodejs:20 -y
dnf module start nodejs -y

cp cart.service /tmp/systemd/system/cart.service

useradd roboshop

mkdir /app

curl -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart-v3.zip

cd /app

unzip /tmp/cart.zip

npm install

systemctl daemon-reload

systemctl enable cart
systemctl restart cart
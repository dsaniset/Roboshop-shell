dnf install golang -y

useradd roboshop

mkdir /app

curl -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch-v3.zip

cd /app

unzip /tmp/dispatch.zip

cd /app
go mod init dispatch
go get
go build

cp dispatch.service /etc/systemd/system/

systemctl daemon-reload

systemctl enable dispatch
systemctl start dispatch
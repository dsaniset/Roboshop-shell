source common.sh

print_heading "Copying the dispatch.service"
cp dispatch.service /etc/systemd/system/dispatch.service

print_heading "Installing GoLang"
dnf install golang -y

print_heading "Added application user"
useradd roboshop

print_heading "Created application folder"
rm -rf /app
mkdir /app

print_heading "Downloading the application"
curl -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch-v3.zip
cd /app
unzip /tmp/dispatch.zip

print_heading "Downloading the dependencies"
go mod init dispatch
go get
go build

print_heading "Starting the application"
systemctl daemon-reload
systemctl enable dispatch
systemctl restart dispatch
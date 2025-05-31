source common.sh

echo -e "$color Copying the dispatch.service $no_color"
cp dispatch.service /etc/systemd/system/dispatch.service

echo -e "$color installing GoLang $no_color "
dnf install golang -y

echo -e "$color Added application user $no_color "
useradd roboshop

echo -e "$color Created application folder $no_color "
rm -rf /app
mkdir /app

echo -e "$color Downloading the application $no_color "
curl -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch-v3.zip
cd /app
unzip /tmp/dispatch.zip

echo -e "$color Downloading the dependencies $no_color "
go mod init dispatch
go get
go build

echo -e "$color Starting the application $no_color "
systemctl daemon-reload
systemctl enable dispatch
systemctl restart dispatch
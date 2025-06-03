source common.sh
app_name=frontend

print_heading "Disabling Nginx"
dnf module disable nginx -y &>>$log_file
status_check $?

print_heading "Enabling Nginx"
dnf module enable nginx:1.24 -y &>>$log_file
status_check $?

print_heading "Installing Nginx"
dnf install nginx -y &>>$log_file
status_check $?

print_heading "Copy Nginx config"
cp nginx.conf /etc/nginx/nginx.conf &>>$log_file
status_check $?

rm -rf /usr/share/nginx/html/*

print_heading "Downloading Application"
curl -o /tmp/$app_name.zip https://roboshop-artifacts.s3.amazonaws.com/$app_name-v3.zip &>>$log_file
cd /usr/share/nginx/html
unzip /tmp/$app_name.zip &>>$log_file
status_check $?

print_heading "Starting Nginx service"
systemctl enable nginx &>>$log_file
systemctl restart nginx &>>$log_file
status_check $?
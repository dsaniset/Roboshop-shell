source common.sh
app_name=frontend

print_heading "Disabling Nginx"
dnf module disable nginx -y

print_heading "Enabling Nginx"
dnf module enable nginx:1.24 -y

print_heading "Installing Nginx"
dnf install nginx -y

print_heading "Copy Nginx config"
cp nginx.conf /etc/nginx/nginx.conf

rm -rf /usr/share/nginx/html/*

print_heading "Downloading Application"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

print_heading "Starting Nginx service"
systemctl enable nginx
systemctl restart nginx
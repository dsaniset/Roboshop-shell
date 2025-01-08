dnf module disable nginx -y
dnf module enable nginx:1.24 -y
dnf module start nginx -y

systemctl enable nginx
systemctl start nginx

rm -rf /usr/share/nginx/html/*

curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip

cd /usr/share/nginx/html

unzip /tmp/fronend.zip

cp nginx.conf /etc/nginx/

systemctl restart nginx
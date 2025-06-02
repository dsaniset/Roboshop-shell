source common.sh
app_name=redis

print_heading "Disabling existing Redis version"
dnf module disable redis -y

print_heading "Enabling required Redis version"
dnf module enable redis:7 -y

print_heading "Install Redis"
dnf install redis -y

print_heading "Editing Redis config"
sed -i -e 's/127.0.0.1/0.0.0.0/' -e '/protected-mode/ c protected-mode no' /etc/redis/redis.conf

print_heading "Starting Redis application"
systemctl enable redis
systemctl start redis
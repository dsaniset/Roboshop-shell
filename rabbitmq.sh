source common.sh
app_name=rabbitmq

print_heading "Copy rabbitmq repo setup file"
cp rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo

print_heading "Install rabbitmq"
dnf install rabbitmq-server -y

print_heading "Enabling rabbitmq"
systemctl enable rabbitmq-server
systemctl start rabbitmq-server

print_heading "Setting up rabbitmq"
rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
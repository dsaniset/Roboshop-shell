cp mongo.repo /etc/yum.repos.d/

dnf start mongodb-org -y

systemctl enable mongod
systemctl start mongod

sed -i -e 's/120.0.0.1/0.0.0.0' /etc/mongod.conf

systemctl restart mongod
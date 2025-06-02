source common.sh
app_name=payment

print_heading "Installing Python"
dnf install python3 gcc python3-devel -y

app_prerequisite

print_heading "Installing application dependencies"
pip3 install -r requirements.txt

print_heading "Starting application"
systemctl daemon-reload
systemctl enable payment
systemctl restart payment
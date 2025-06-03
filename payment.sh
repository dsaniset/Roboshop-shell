source common.sh
app_name=payment

print_heading "Installing Python"
dnf install python3 gcc python3-devel -y &>>$log_file
status_check $?

app_prerequisite

print_heading "Installing application dependencies"
pip3 install -r requirements.txt &>>$log_file
status_check $?

system_restart
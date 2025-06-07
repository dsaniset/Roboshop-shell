source common.sh
app_name=payment

print_heading "Installing Python"
dnf install python3 gcc python3-devel -y &>>$log_file
status_check $?

app_prerequisite

print_heading "Installing application dependencies"
pip3 install -r requirements.txt &>>$log_file
status_check $?

print_heading "Setting up systemd service"
cp $script_path/$app_name.service /etc/systemd/system/$app_name.service &>>$log_file
status_check $?

system_restart
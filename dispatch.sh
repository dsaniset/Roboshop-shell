source common.sh
app_name=dispatch

print_heading "Copying the dispatch.service"
cp $app_name.service /etc/systemd/system/$app_name.service &>>$log_file
status_check $?

print_heading "Installing GoLang"
dnf install golang -y &>>$log_file
status_check $?

app_prerequisite

print_heading "Downloading the dependencies"
go mod init $app_name &>>$log_file
go get &>>$log_file
go build &>>$log_file
status_check $?

system_restart
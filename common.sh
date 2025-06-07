color="\e[35m"
no_color="\e[0m"
log_file=/tmp/roboshop.log
rm -f $log_file
script_path=$(pwd)

print_heading(){
  echo -e "$color $1 $no_color"
  echo -e "$color $1 $no_color" &>>$log_file
}

status_check(){
  if [ $1 -eq 0 ]; then
    echo -e "\e[32m SUCCESS \e[0m"
  else
    echo -e "\e[31m FAILURE \e[0m"
    exit 1
  fi
}

app_prerequisite(){
  print_heading "Creating user"
  id roboshop &>>$log_file
  if [ $? -ne 0 ]; then
    useradd roboshop &>>$log_file
  fi
  status_check $?

  print_heading "Creating application folder"
  rm -rf /app
  mkdir /app
  status_check $?

#  print_heading "Downloading $app_name application"
#  curl -o /tmp/$app_name.zip https://roboshop-artifacts.s3.amazonaws.com/$app_name-v3.zip &>>$log_file
#  cd /app
#  unzip /tmp/$app_name.zip &>>$log_file
#  status_check $?

  if [ ! -f /tmp/$app_name.zip ]; then
    print_heading "Downloading $app_name application"
    curl -o /tmp/$app_name.zip https://roboshop-artifacts.s3.amazonaws.com/$app_name-v3.zip &>>$log_file
    status_check $?
  else
    print_heading "$app_name.zip already exists, skipping download"
  fi

  if [ -z "$(ls -A /app)" ]; then
    print_heading "Unzipping $app_name.zip to /app"
    unzip -n /tmp/$app_name.zip -d /app &>>$log_file
    status_check $?
  else
    print_heading "/app already has files, skipping unzip"
  fi

}

nodejs_setup(){

  print_heading "Enabling and installing nodejs"
  dnf module disable nodejs -y &>>$log_file
  dnf module enable nodejs:20 -y &>>$log_file
  dnf install nodejs -y &>>$log_file
  status_check $?

  app_prerequisite

  print_heading "Installing application dependencies"
  npm install &>>$log_file
  status_check $?

  system_restart
}

system_restart(){
  print_heading "Setting up systemd service"
  cp $script_path/$app_name.service /etc/systemd/system/$app_name.service &>>$log_file
  status_check $?

  print_heading "Reloading systemd and restarting the service"
  systemctl daemon-reload &>>$log_file
  systemctl enable $app_name &>>$log_file
  systemctl restart $app_name &>>$log_file
  status_check $?
}
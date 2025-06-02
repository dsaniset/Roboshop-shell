color="\e[35m"
no_color="\e[0m"
script_path=$(pwd)

print_heading(){
  echo -e "$color $1 $no_color"
}

app_prerequisite(){
  useradd roboshop
  mkdir /app
  curl -o /tmp/$app_name.zip https://roboshop-artifacts.s3.amazonaws.com/$app_name-v3.zip
  cd /app
  unzip /tmp/$app_name.zip
}

nodejs_setup(){
  print_heading "Setting up systemd service"
  cp $script_path/$app_name.service /etc/systemd/system/$app_name.service

  print_heading "Enabling and installing nodejs"
  dnf module disable nodejs -y
  dnf module enable nodejs:20 -y
  dnf module install nodejs -y

  app_prerequisite

  print_heading "Installing application dependencies"
  npm install

  system_restart
}

system_restart(){
  print_heading "Reloading systemd and restarting the service"
    systemctl daemon-reload
    systemctl enable $app_name
    systemctl restart $app_name
}
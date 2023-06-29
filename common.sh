app_path="/app"
color="\e[33m"
nocolor="\e[0m"
log_file="/tmp/roboshop.log"

pre_setup () {
  echo -e "${color} ADDING ROBOSHOP USER${nocolor}"
  useradd roboshop &>>${log_file}

  echo -e "${color} REMOVING AND ADDING APP FOLDER${nocolor}"
  rm -rf ${app_path} &>>${log_file}
  mkdir ${app_path} &>>${log_file}

  echo -e "${color} ADDED ${component} CONTENT${nocolor}"
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log_file}

  echo -e "${color} UNZIP ${component} CONTENT${nocolor}"
  cd ${app_path}
  unzip /tmp/${component}.zip &>>${log_file}

}
systemd () {
  echo -e "${color} COPYING ${component} SERVICE${nocolor}"
  cp /home/centos/roboshop-shell/${component}.service /etc/systemd/system/${component}.service &>>${log_file}

  echo -e "${color} STARTING ${component} SERVICE${nocolor}"
  systemctl daemon-reload &>>${log_file}
  systemctl enable ${component} &>>${log_file}
  systemctl restart ${component} &>>${log_file}
}

nodejs() {
  echo -e "${color} CONFIGURING NODEJS${nocolor}"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}

  echo -e "${color} INSTALLING NODEJS${nocolor}"
  yum install nodejs -y &>>${log_file}

  pre_setup

  echo -e "${color} INSTALLING NODEJS DEPENDENCIES${nocolor}"
  cd ${app_path}
  npm install &>>${log_file}

  systemd

}

maven () {
  echo  -e "${color}INSTALLING MAVEN${nocolor}"
  yum install maven -y &>>${log_file}

  pre_setup

  echo -e "${color}MAVEN PACKAGE${nocolor}"
  cd ${app_path}
  mvn clean package &>>${log_file}
  mv target/${component}-1.0.jar ${component}.jar &>>${log_file}

  systemd

  mysql_schema_setup
}

mongo_schema_setup() {
  echo -e "${color} COPYING MONGODB REPO${nocolor}"
  cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${log_file}

  echo -e "${color} INSTALLING MONGODB SHELL${nocolor}"
  yum install mongodb-org-shell -y &>>${log_file}

  echo -e "${color} LOAD SCHEMA${nocolor}"
  mongo --host mongodb-dev.devopsbjr.online <${app_path}/schema/${component}.js &>>${log_file}
}

mysql_schema_setup() {
  echo -e "${color}INSTALLING MYSQL${nocolor}"
  yum install mysql -y &>>${log_file}

  echo -e "${color}SCHEMA LOADING${nocolor}"
  mysql -h mysql-dev.devopsbjr.online -uroot -pRoboShop@1 < ${app_path}/schema/${component}.sql &>>${log_file}


}

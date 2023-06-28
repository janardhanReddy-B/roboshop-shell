echo -e "\e[33mCONFIGURING NODEJS\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "\e[33mINSTALLING NODEJS\e[0m"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[33mADDING ROBOSHOP USER\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[33mREMOVING AND ADDING APP FOLDER\e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[33mADDED USER CONTENT\e[0m"
curl -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>>/tmp/roboshop.log

echo -e "\e[33mUNZIP USER CONTENT\e[0m"
cd /app
unzip /tmp/user.zip &>>/tmp/roboshop.log

echo -e "\e[33m INSTALLING NODEJS DEPENDENCIES\e[0m"
cd /app
npm install &>>/tmp/roboshop.log

echo -e "\e[33mCOPYING USER SERVICE\e[0m"
cp /home/centos/roboshop-shell/user.service /etc/systemd/system/user.service &>>/tmp/roboshop.log


echo -e "\e[33mSTARTING USER SERVICE\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable catalogue &>>/tmp/roboshop.log
systemctl restart catalogue &>>/tmp/roboshop.log

echo -e "\e[33mCOPYING MONGODB REPO\e[0m"
cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>/tmp/roboshop.log

echo -e "\e[33mINSTALLING MONGODB SHELL\e[0m"
yum install mongodb-org-shell -y &>>/tmp/roboshop.log

echo -e "\e[33mRUNNING MONGODB SCHEMA\e[0m"
mongo --host mongodb-dev.devopsbjr.online </app/schema/user.js &>>/tmp/roboshop.log


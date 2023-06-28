echo -i -e "\e[33mINSTALLING GOLANG\e[om"
yum install golang -y &>>/tmp/roboshop.log

echo -i -e "\e[33mADDING USER\e[om"
useradd roboshop &>>/tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log

echo -i -e "\e[33mGETTING DISPATCH CONTENT\e[om"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip &>>/tmp/roboshop.log
cd /app

echo -i -e "\e[33mUNZIP DISPATCH CONTENT\e[om"
unzip /tmp/dispatch.zip &>>/tmp/roboshop.log
cd /app &>>/tmp/roboshop.log

echo -i -e "\e[33m INITIALIZE AND AND BUILD DISPATCH\e[om"
go mod init dispatch &>>/tmp/roboshop.log
go get &>>/tmp/roboshop.log
go build &>>/tmp/roboshop.log

echo -i -e "\e[33mCOPYING GOLANG SERVICE\e[om"
cp /home/centos/roboshop-shell/dispatch.service /etc/systemd/system/dispatch.service &>>/tmp/roboshop.log

echo -i -e "\e[33mSTARTING GOLANG\e[om"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable dispatch &>>/tmp/roboshop.log
systemctl start dispatch &>>/tmp/roboshop.log
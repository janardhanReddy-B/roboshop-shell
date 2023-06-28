echo  -e "\e[33mINSTALLING GOLANG\e[0m"
yum install golang -y &>>/tmp/roboshop.log

echo  -e "\e[33mADDING USER\e[0m"
useradd roboshop &>>/tmp/roboshop.log
rm -rf /app &>>/tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[33mGETTING DISPATCH CONTENT\e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[33mUNZIP DISPATCH CONTENT\e[0m"
unzip /tmp/dispatch.zip &>>/tmp/roboshop.log
cd /app &>>/tmp/roboshop.log

echo -e "\e[33m INITIALIZE AND AND BUILD DISPATCH\e[0m"
go mod init dispatch &>>/tmp/roboshop.log
go get &>>/tmp/roboshop.log
go build &>>/tmp/roboshop.log

echo -e "\e[33mCOPYING GOLANG SERVICE\e[0m"
cp /home/centos/roboshop-shell/dispatch.service /etc/systemd/system/dispatch.service &>>/tmp/roboshop.log

echo -e "\e[33mSTARTING GOLANG\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable dispatch &>>/tmp/roboshop.log
systemctl start dispatch &>>/tmp/roboshop.log
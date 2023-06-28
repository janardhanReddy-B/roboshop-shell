echo -i -e "\e[33mINSTALLING MAVEN\e[0m"
yum install maven -y &>>/tmp/roboshop.log

echo -e "\e[33mADDING USERe[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[33mREMOVING AND ADDING APP FOLDER\e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[33mADDED SHIPPING CONTENT\e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[33mUNZIP SHIPPING CONTENT\e[0m"
unzip /tmp/shipping.zip &>>/tmp/roboshop.log

echo -e "\e[33mMAVEN PACKAGE\e[0m"
cd /app
mvn clean package &>>/tmp/roboshop.log
mv target/shipping-1.0.jar shipping.jar &>>/tmp/roboshop.log

echo -e "\e[33mCOPYING SHIPPING SERVICE\e[0m"
cp /home/centos/roboshop-shell/shipping.service /etc/systemd/system/shipping.service &>>/tmp/roboshop.log

echo -e "\e[33mINSTALLING MYSQL\e[0m"
yum install mysql -y &>>/tmp/roboshop.log

echo -e "\e[33mSCHEMA LOADING\e[0m"
mysql -h mysql-dev.devopsbjr.online -uroot -pRoboShop@1 < /app/schema/shipping.sql &>>/tmp/roboshop.log

echo -e "\e[33mSTARTING SHIPPING\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable shipping &>>/tmp/roboshop.log
systemctl restart shipping &>>/tmp/roboshop.log

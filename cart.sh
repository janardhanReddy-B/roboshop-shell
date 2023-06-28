echo -e "\e[33mCONFIGURING NODEJS\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "\e[33mINSTALLING NODEJS\e[0m"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[33mADDING ROBOSHOP USER\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[33mREMOVING AND ADDING APP FOLDER\e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[33mADDED CART CONTENT\e[0m"
curl -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>>/tmp/roboshop.log

echo -e "\e[33mUNZIP CART CONTENT\e[0m"
cd /app
unzip /tmp/cart.zip &>>/tmp/roboshop.log

echo -e "\e[33m INSTALLING NODEJS DEPENDENCIES\e[0m"
cd /app
npm install &>>/tmp/roboshop.log

echo -e "\e[33mCOPYING CART SERVICE\e[0m"
cp /home/centos/roboshop-shell/cart.service /etc/systemd/system/cart.service &>>/tmp/roboshop.log


echo -e "\e[33mSTARTING CATALOGUE SERVICE\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable catalogue &>>/tmp/roboshop.log
systemctl restart catalogue &>>/tmp/roboshop.log
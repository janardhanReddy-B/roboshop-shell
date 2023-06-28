echo -i -e "\e[33mINSTALLING PYTHON\e[0m"
yum install python36 gcc python3-devel -y &>>/tmp/roboshop.log

echo -i -e "\e[33mADDING USER\e[0m"
useradd roboshop &>>/tmp/roboshop.log
rm -rf /app &>>/tmp/roboshop.log
mkdir /app

echo -i -e "\e[33mADDED PAYMENT CONTENT\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip &>>/tmp/roboshop.log
cd /app

echo -i -e "\e[33mUNZIP PAYMENT CONTENT\e[0m"
unzip /tmp/payment.zip &>>/tmp/roboshop.log
cd /app

echo -i -e "\e[33mINSTALLING PIP3 AND REQUIREMENTS\e[0m"
pip3.6 install -r requirements.txt &>>/tmp/roboshop.log

echo -i -e "\e[33mCOPYING PAYMENT SERVICE\e[0m"
cp /home/centos/roboshop-shell/payment.service /etc/systemd/system/payment.service &>>/tmp/roboshop.log

echo -i -e "\e[33mSTARTING PAYMENT\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable payment &>>/tmp/roboshop.log
systemctl start payment &>>/tmp/roboshop.log
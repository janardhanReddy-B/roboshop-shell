curl -sL https://rpm.nodesource.com/setup_lts.x | bash

yum install nodejs -y

useradd roboshop

rm -rf /app
mkdir /app

curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
unzip /tmp/catalogue.zip

cd /app
npm install

cp /home/centos/roboshop-shell/catalogue.service /etc/systemd/system/catalogue.service

yum install mongodb-org-shell -y
mongo --host mongodb-dev.devopsbjr.online </app/schema/catalogue.js



systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue
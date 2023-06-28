echo -e "\e[33mCOPYING MONGODB REPO\e[om"
cp mongodb.repo /etc/yum.repos.d/mongodb.repo &>>/tmp/roboshop.log

echo -e "\e[33mINSTALLING MONGODB\e[om"
yum install mongodb-org -y &>>/tmp/roboshop.log

echo -e "\e[33mSECRACH AND REPLACE\e[om"
sed -i -e 's?127.0.0.1?0.0.0.0?' /etc/mongod.conf

echo -e "\e[33mSTARTING MONGODB\e[om"
systemctl enable mongod &>>/tmp/roboshop.log
systemctl restart mongod &>>/tmp/roboshop.log
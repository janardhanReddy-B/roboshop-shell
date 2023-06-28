echo -e "\e[33mCOPYING MONGODB REPO\e[0m"
cp mongodb.repo /etc/yum.repos.d/mongodb.repo &>>/tmp/roboshop.log

echo -e "\e[33mINSTALLING MONGODB\e[0m"
yum install mongodb-org -y &>>/tmp/roboshop.log

echo -e "\e[33mSCREECH AND REPLACE\e[0m"
sed -i -e 's?127.0.0.1?0.0.0.0?' /etc/mongod.conf  &>>/tmp/roboshop.log

echo -e "\e[33mSTARTING MONGODB\e[0m"
systemctl enable mongod &>>/tmp/roboshop.log
systemctl restart mongod &>>/tmp/roboshop.log
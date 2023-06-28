echo -e "\e[33mDISABLE MYSQL\e[0m"
yum module disable mysql -y &>>/tmp/roboshop.log

echo -e "\e[33mCOPYING MYSQL.REPO\e[0m"
cp /home/centos/roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo &>>/tmp/roboshop.log

echo -e "\e[33mINSTALLING MYSQL\e[0m"
yum install mysql-community-server -y &>>/tmp/roboshop.log

echo -e "\e[33mSTARTING MYSQL\e[0m"
systemctl enable mysqld &>>/tmp/roboshop.log
systemctl restart mysqld &>>/tmp/roboshop.log

echo -e "\e[33mCHANGING MYSQL ROOT PASSWORD\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1 &>>/tmp/roboshop.log

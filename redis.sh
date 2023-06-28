echo  -e "\e[33mINSTALLING REPO FILES FOR REDIS\e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>/tmp/roboshop.log

echo  -e "\e[33mINSTALLING REDIS\e[0m"
yum module enable redis:remi-6.2 -y &>>/tmp/roboshop.log
yum install redis -y &>>/tmp/roboshop.log

echo  -e "\e[33mCHANGING CONF FILE\e[0m"
sed -i -e 's?127.0.0.1?0.0.0.0?' /etc/redis.conf /etc/redis/redis.conf &>>/tmp/roboshop.log

echo -e "\e[33mSTARTING REDIS\e[0m"
systemctl enable redis &>>/tmp/roboshop.log
systemctl restart redis &>>/tmp/roboshop.log
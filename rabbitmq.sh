

echo -e "\e[33mConfigure YUM Repos from the vendor\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>/tmp/roboshop.log

echo -e "\e[33mConfigure YUM Repos for RabbitMQ\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>/tmp/roboshop.log

echo -e "\e[33mINSTALLING RABBITMQ\e[0m"
yum install rabbitmq-server -y &>>/tmp/roboshop.log

echo -e "\e[33mSTARTING RABBITMQ\e[0m"
systemctl enable rabbitmq-server &>>/tmp/roboshop.log
systemctl restart rabbitmq-server &>>/tmp/roboshop.log

echo -e "\e[33mADDING ROBOSHOP USER TO RABBITMQ \e[0m"
rabbitmqctl add_user roboshop roboshop123 &>>/tmp/roboshop.log

echo -e "\e[33mGIVING PERMISSION  RABBITMQ\e[0m"
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>/tmp/roboshop.log
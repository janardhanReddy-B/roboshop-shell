
echo -e "\e[33mINSTALLING NGINX\e[0m"
yum install nginx -y  &>>/tmp/roboshop.log

echo -e "\e[33mREMOVING OLD CONTENT\e[0m"
rm -rf /usr/share/nginx/html/*  &>>/tmp/roboshop.log

echo -e "\e[33mDOWNLOADING FRONTEND CONTENT\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/roboshop.log

echo -e "\e[33mUNZIPPING FRONTEND CONTENT\e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>/tmp/roboshop.log

echo -e "\e[33mCOPYING ROBOSHOP CONF FILE\e[0m"
cp /home/centos/roboshop-shell/roboshop.conf /etc/nginx/default.d/roboshop.conf &>>/tmp/roboshop.log

echo -e "\e[33mSTARTING NGINX SERVER\e[0m"
systemctl enable nginx &>>/tmp/roboshop.log
systemctl restart nginx &>>/tmp/roboshop.log

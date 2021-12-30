Task description

Your goal is to takeover already registered accounts.

Instructions

sudo apt install php php-pear php-dev apache2 libapache2-mod-php  
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -  
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list  
sudo apt install -y mongodb-org  
sudo pecl install mongodb  

add the following line:  
extension=mongodb.so  

to the files:  
/etc/php/7.4/cli/php.ini  
/etc/php/7.4/apache2/php.ini  

sudo systemctl start mongod  
sudo service apache2 start  

copy application files to the /var/www/html folder  

chmod -R 777 /var/www/html/uploads/  

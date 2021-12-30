Description

Hello, Mr. Hacker!
I've managed to steal this backup from some careless novice Ruby developer. He thinks that this is secure password manager, lol. 
So, your task is clear: you should find out the admin user (name of the account is somehow connected with InfoSecBY), obtain this account and get the flag.
I've got the information that developer changed stuff like ip addresses, id, usernames and passwords, etc., so if you find them in the code, they will not help you. Still, I believe in you. Happy hacking!

creds_locker.rb - was provided to the competitors
creds_locker_task.rb - version for deploying the task

Instructions

sudo apt install ruby ruby-dev libmysqlclient-dev libssl-dev libreadline-dev zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev mysql-server  
sudo gem install mysql2  
sudo gem install bcrypt  
sudo gem install digest  
sudo service mysql start  

sudo mysql
  create cbc;  
  use cbc;  
  create table rub (id int(11) NOT NULL AUTO_INCREMENT, username varchar(100) NOT NULL, password varchar(100) NOT NULL, PRIMARY KEY(id));  
  insert into rub (id, username, password) values (483647, 'INFOSECBY_FLAG_USER', '4c6c8cc22adad23c64d510362a50d265483a6cb6');  
  create table data (id int(11) NOT NULL AUTO_INCREMENT, username varchar(100) NOT NULL, email varchar(100) NOT NULL, password varchar(100) NOT NULL, owner int(11) DEFAULT NULL, PRIMARY KEY(id));  
  create table flag(flag varchar(50));  
  insert into flag (flag) VALUES ('flag{d0_n0t_wr1t3_c0d3_l1k3_th15}');  
  create user reg@localhost identified by 'reg';  
  grant all privileges on cbc.rub to reg@localhost;  
  create user manager@localhost identified by 'manager';  
  grant all privileges on cbc.data to manager@localhost;  
  create user admin@localhost identified by 'admin';  
  grant all privileges on cbc.flag to admin@localhost;  
  flush privileges;  
  
ruby creds_locker_task.rb

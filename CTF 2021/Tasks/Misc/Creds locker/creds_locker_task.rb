require 'mysql2'  
require "socket"
require "bcrypt"
require "digest/sha1"
class Server
	def initialize( port, ip )
		@server = TCPServer.open( ip, port )
		@connections = Hash.new
		@connections[:server] = @server
		@semaphore = Mutex.new
		run
	end

	def run 
		loop {
			Thread.start(@server.accept) do | client |
def db_login(username, password)
	id = ""
	@con1 = Mysql2::Client.new(:host => "127.0.0.1", :username => "reg", :database => "cbc", :password => "reg")
	f = @con1.query("select id from rub where username = '#{username}' and password = '#{password}'")
	if f.count == 1
		f.each do |row|
			id = @con1.escape(row['id'].to_s)
		end
	end
	@con1.close()
	return f, id
end

def db_reg(username, password)
	id = ""
	@con1 = Mysql2::Client.new(:host => "127.0.0.1", :username => "reg", :database => "cbc", :password => "reg")
	username = @con1.escape(username)
	f = @con1.query("select id from rub where username = '#{username}'")
	f.each do |row|
		id = @con1.escape(row['id'].to_s)
	end
	if id.empty?
		@con1.query("INSERT INTO rub (username, password) VALUES('#{username}', '#{password}')")
	end
	@con1.close()
	return id
end

def db_get(id)
	@con = Mysql2::Client.new(:host => "127.0.0.1", :username => "manager", :database => "cbc", :password => "manager")
	f = @con.query("SELECT * FROM data where owner=#{id}")
	@con.close()
	return f
end

def db_get_flag()
	@con = Mysql2::Client.new(:host => "127.0.0.1", :username => "admin", :database => "cbc", :password => "admin")
	f = @con.query("SELECT flag FROM flag")
	@con.close()
	return f
end

def db_add(username, email, password, id)
	@con = Mysql2::Client.new(:host => "127.0.0.1", :username => "manager", :database => "cbc", :password => "manager")
	user = @con.escape(username)
	email = @con.escape(email)
	pass = @con.escape(password)
	@con.query("INSERT INTO data (username, email, password, owner) VALUES('#{user}', '#{email}', '#{pass}', '#{id}')")
	@con.close
end

def st(client, id)
	if !id.empty?
		menu(client, id)
	end 
	client.puts "Enter [1] if you want to log in.\n" 
	client.puts "Enter [2] if you want to register.\n"
	client.puts "Enter [3] Exit"
	ch = client.gets.chomp
	case ch
		when "1"
			login(client)
		when "2"
			register(client)
		when "3"
			client.puts "Good luck!\n"
			client.close()
		else
			client.puts "You gave #{ch} -- Server has no idea what to do with that.\n"
			st(client, id)
	end
end


def menu(client, id)
	client.puts "Enter [1] if you want to look at your passwords.\n"
	client.puts "Enter [2] if you want to add new password.\n"
	client.puts "Enter [3] if you want to get the flag" 
	client.puts "Enter [4] Logout"
	ch = client.gets.chomp
	case ch
		when "1"
			get_data(client, id)
		when "2"
			add_password(client, id)
		when "3"
			if id == "483647"
				get_flag(client, id)
			else
				client.puts "Come on! It won't be so easy."
				menu(client, id)
			end
		when "4"
			id = ""
			st(client, id)
		else
			client.puts "You gave me #{ch} -- I have no idea what to do with that.\n"
			menu(client, id)
	end
end


def get_flag(client, id)
	f = @semaphore.synchronize {
		db_get_flag()
	}
	f.each do |row|
		client.puts "FLAG: '#{row['flag']}'"
	end
	menu(client, id)
end

def get_data(client, id)
	f = @semaphore.synchronize {
		db_get(id)
	}
	f.each do |row|
		client.puts "Username: '#{row['username']}' Email: '#{row['email']}' Password: '#{row['password']}'"
	end
	menu(client, id)
end

def add_password(client, id)
	client.puts "Enter username\n"
	user = client.gets.chomp
	client.puts "Enter email address\n"
	email = client.gets.chomp
	client.puts "Enter password\n"
	pass = client.gets.chomp
	@semaphore.synchronize {
		db_add(user, email, pass, id)
	}
	client.puts "Success!\n"
	menu(client,id)
end

def register(client)
	client.puts "Enter username\n"
	username = client.gets.chomp
	client.puts "Enter password\n"
	password = Digest::SHA1.hexdigest client.gets.chomp
	id = @semaphore.synchronize {
		db_reg(username,password)
	}
	if id.empty?
		client.puts "Success!\n"
		st(client, id)
	else
		client.puts "User already exists.\n"
		st(client, id)
	end
end


def login(client)
	client.puts "Enter username\n"
	username = client.gets.chomp
	client.puts "Enter password\n"
	password = Digest::SHA1.hexdigest client.gets.chomp
	f = @semaphore.synchronize {
		db_login(username, password)
	}
	id = f[1]
	if f[0].count == 1
		client.puts "Success!\n"
		menu(client, id)
	else 
		client.puts "Login failed.\n"
		st(client, id)
	end
end
				
				client.puts "

                                    /&@&*                 
                            %@@@@#         %@@@@/         
                         @@@                     @@@      
                      &@@           &@@@%           @@*   
                     @@          @@@     @@@          @@  
                   /@&          @@         @@          @@ 
                   @@          @@           @%          @@
                  &@*       (@@@@@@@@@@@@@@@@@@@        @@
                  (@(       &@@@@@@@@@@@@@@@@@@@.       @@
                   @@       &@@@@@@@@  ,@@@@@@@@.       @@
                    @@      &@@@@@@@@. /@@@@@@@@.      @@ 
                     @@     &@@@@@@@@@@@@@@@@@@@.    *@@  
                       @@*                         %@@    
                         (@@@                   @@@.      
                             (@@@@@@%#(#&@@@@@@,          
                                      
			      	CREDS LOCKER 
 
"
				
				st(client, "")
			end
		}.join
	end
end

Server.new( 7777, "0.0.0.0" )

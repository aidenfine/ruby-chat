require 'socket'
require 'set'
require 'rainbow/refinement'
using Rainbow

server = TCPServer.new('localhost', 3002)

clients = {}
usernames_set = Set.new()


loop do
  client = server.accept

  Thread.new(client) do |socket|
    begin
      username = socket.gets&.chomp 
      next if username.nil?
        clients[socket] = username
        if usernames_set.include?(username)
          socket.puts "Username is already taken"
          socket.close
        end

        usernames_set.add(username)
        puts "#{username} connected".green

        socket.puts "Welcome to ruby chat, #{username}"

        loop do
          msg = socket.gets
          break if msg.nil?
          puts "#{username}: #{msg}"
        end
    rescue Errno::ECONNRESET
        puts "#{clients[socket]} disconnected unexpenctly".red
    ensure
        clients.delete(socket)
        if usernames_set.include?(username)
          usernames_set.delete(username)
        end
        socket.close
    end
  end
end
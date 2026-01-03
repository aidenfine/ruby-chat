# frozen_string_literal: true

require_relative "chat/version"
require 'socket'

socket = TCPSocket.new('localhost', 3002)

puts "Welcome! to ruby-chat"
puts "What should people call you?"

users_name = gets.chomp
while users_name.length > 50
  puts "Username should be less than 50 chars"
  puts "What should people call you?"
  users_name = gets.chomp
end

puts "username: #{users_name}"

socket.puts(users_name)
puts "connected as #{users_name}"

Thread.new do 
  puts socket.gets
  while (msg = socket.gets)

    puts msg
  end
end

loop do 
  message = gets.chomp
  socket.puts(message)
end



require 'socket'

BasicSocket.do_not_reverse_lookup = true

@socket = UDPSocket.new
@socket.setsockopt(Socket::SOL_SOCKET,Socket::SO_BROADCAST, 1)
@socket.bind("127.0.0.1", 80)

while true
  begin
    data, client = @socket.recvfrom(1024)
    Thread.new(client) do |clientAddress|
      puts "New client #{clientAddress[1]} has joined with message:\n#{data}"
      begin
        @socket.send("#{clientAddress[2]}:#{clientAddress[1]}, your message was recieved", 0, clientAddress[2], clientAddress[1])
      
      rescue Exception => e
        puts "Some error in recieving: #{e.message}"
      end
    end
    
    rescue Errno::ECONNRESET
      puts "Connection was reset"
  end
end

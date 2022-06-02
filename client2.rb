require 'socket'

class UDPClient
  def initialize(host, port)
    @host = host
    @port = port
  end

  def start
    @socket = UDPSocket.new
    @socket.setsockopt(Socket::SOL_SOCKET,Socket::SO_BROADCAST, 1)
    @socket.bind(@host, @port)
    
    @socket.send("Message from cicle first client", 0, @host, 80)
    sleep 2

    data, server = @socket.recvfrom(1024)
    puts "#{data}\nServer: #{server[2]}:#{server[1]}"
  end
end

client = UDPClient.new("127.0.0.1", 82) # 10.10.129.139 is the IP of UDP server
client.start
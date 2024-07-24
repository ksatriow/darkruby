require 'socket'

module NetworkScan
  def self.port_scan(target, ports)
    ports.each do |port|
      begin
        sock = TCPSocket.new(target, port)
        puts "Port #{port} open"
        sock.close
      rescue
        puts "Port #{port} closed"
      end
    end
  end
end

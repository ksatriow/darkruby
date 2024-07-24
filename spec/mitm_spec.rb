require 'rspec'
require_relative '../lib/mitm_attack'

RSpec.describe MitmAttack do
  it 'should start MITM attack' do
    expect { MitmAttack.mitm_attack('eth0', '192.168.1.3', '192.168.1.1') }.not_to raise_error
  end
end

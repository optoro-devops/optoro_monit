require 'spec_helper'

describe 'Monit redis configuration' do
  it 'exist' do
    expect(file('/etc/monit/conf.d/redis6379.conf')).to be_file
  end

  it 'is monitored' do
    expect(command('monit status | grep -A2 redis6379 | egrep "monitoring status" | awk "{ print $3 }"').stdout).to match('Monitored')
  end
end

require 'spec_helper'

describe 'Monit redis configuration' do
  it 'exist' do
    expect(file('/etc/monit/conf.d/6379.conf')).to be_file
  end

  sleep 30
  it 'is monitored' do
    expect(command('monit status 2>/dev/null | grep -A2 6379 | egrep "monitoring status" | awk "{ print $3 }"').stdout).to match('Monitored')
  end
end

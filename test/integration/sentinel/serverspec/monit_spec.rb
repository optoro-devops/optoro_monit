require 'spec_helper'

describe 'Monit sentinel configuration' do
  it 'exist' do
    expect(file('/etc/monit/conf.d/sentinel.conf')).to be_file
  end

  sleep 30
  it 'is monitored' do
    expect(command('monit status 2>/dev/null | grep -A2 sentinel | egrep "monitoring status" | awk "{ print $3 }"').stdout).to match('Monitored')
  end
end

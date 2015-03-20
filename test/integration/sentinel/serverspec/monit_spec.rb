require 'spec_helper'

describe 'Monit sentinel configuration' do
  it 'exist' do
    expect(file('/etc/monit/conf.d/sentinel.conf')).to be_file
  end

  it 'is monitored' do
    expect(command('monit status | grep -A2 sentinel | egrep "monitoring status" | awk "{ print $3 }"').stdout).to match('Monitored')
  end
end

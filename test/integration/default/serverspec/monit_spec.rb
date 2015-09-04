# Serverspec tests for rabbitmq sensu configuration
require 'spec_helper'

describe 'Monit' do
  it 'is enabled' do
    expect(service('monit')).to be_enabled
  end

  it 'is running' do
    expect(service('monit')).to be_running
  end

  it 'has configuration' do
    expect(file('/etc/monit/monitrc')).to be_file
  end

  it 'monitors the server' do
    expect(command('monit status 2>/dev/null | egrep "monitoring status" | awk "{ print $3 }"').stdout).to match('Monitored')
  end
end

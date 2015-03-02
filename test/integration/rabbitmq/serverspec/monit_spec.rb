# Serverspec tests for rabbitmq sensu configuration
require 'spec_helper'

describe 'Monit RabbitMQ configuration' do
  it 'exist' do
    expect(file('/etc/monit/conf.d/rabbitmq.conf')).to be_file
  end

  it 'is monitored' do
    expect(command('monit status | grep -A2 rabbitmq-server | egrep "monitoring status" | awk "{ print $3 }"').stdout).to match('Monitored')
  end
end

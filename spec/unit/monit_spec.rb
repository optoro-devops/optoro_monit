require 'spec_helper'

describe 'optoro_monit::default' do
  let(:chef_run) { ChefSpec::Runner.new(:platform => 'ubuntu', :version => '14.04').converge(described_recipe) }

  before do
    stub_command('which monit').and_return('/usr/bin/monit')
  end

  it 'should create the upstart file' do
    expect(chef_run).to create_cookbook_file('/etc/init/monit.conf')
  end

  it 'should start the monit service' do
    expect(chef_run).to start_service('monit')
  end

  it 'should restart monit if the monitrc is changed' do
    expect(chef_run.template('/etc/monit/monitrc')).to notify('execute[restart-monit]').to(:run).immediately
  end

  it 'should create the monitrc configuration file' do
    expect(chef_run).to create_template('/etc/monit/monitrc').with(
      owner: 'root',
      group: 'root',
      source: 'optoro-monitrc.erb'
    )
  end
end

require 'spec_helper'

describe 'optoro_monit::default' do
  let(:chef_run) { ChefSpec::Runner.new(:platform => 'ubuntu', :version => '14.04').converge(described_recipe) }

  before do
    stub_command('which monit').and_return('/usr/bin/monit')
  end

  it 'should include the community monit cookbook by default' do
    expect(chef_run).to include_recipe 'monit::default'
  end

  it 'should create the init file' do
    expect(chef_run).to create_cookbook_file('/etc/init.d/monit')
  end

  it 'should start the monit service' do
    expect(chef_run).to start_service('monit')
  end

  it 'should override the default monitrc template and use the custom optoro one' do
    expect(chef_run).to_not create_template('/etc/monit/monitrc').with(
      source: 'monitrc.conf.erb'
    )
    expect(chef_run.template('/etc/monit/monitrc')).to notify('service[monit]').to(:restart).delayed
  end

  it 'should create the monitrc configuration file' do
    expect(chef_run).to create_template('/etc/monit/monitrc').with(
      owner: 'root',
      group: 'root',
      source: 'optoro-monitrc.erb'
    )
  end
end

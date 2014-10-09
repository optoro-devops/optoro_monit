require 'spec_helper'

describe 'optoro_monit::optiturn' do
  let(:chef_run) { ChefSpec::Runner.new(:platform => 'ubuntu', :version => '14.04').converge(described_recipe) }

  it 'should create the inventory.monitrc file' do
    expect(chef_run).to create_template('/etc/monit/conf.d/inventory.monitrc').with(
      owner: 'root',
      group: 'root',
      source: 'inventory.monitrc.erb'
    )
    expect(chef_run.template('/etc/monit/conf.d/inventory.monitrc')).to notify('execute[restart-monit]').to(:run).immediately
  end

  it 'should create the nginx.monitrc file' do
    expect(chef_run).to create_template('/etc/monit/conf.d/nginx.monitrc').with(
      owner: 'root',
      group: 'root',
      mode: '600',
      source: 'nginx.monitrc.erb'
    )
    expect(chef_run.template('/etc/monit/conf.d/nginx.monitrc')).to notify('execute[restart-monit]').to(:run).immediately
  end
end

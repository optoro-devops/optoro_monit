require 'spec_helper'

describe 'optoro_monit::optiturn' do
  Resources::PLATFORMS.each do |platform, value|
    value['versions'].each do |version|
      context "On #{platform} #{version}" do
        include_context 'optoro_monit'

        let(:chef_run) do
          ChefSpec::SoloRunner.new(platform: platform, version: version, log_level: :error) do |node|
            node.set['lsb']['codename'] = value['codename']
          end.converge(described_recipe)
        end

        it 'should create the inventory.monitrc file' do
          expect(chef_run).to create_template('/etc/monit/conf.d/inventory.monitrc').with(
            owner: 'root',
            group: 'root',
            source: 'inventory.monitrc.erb'
          )
        end

        it 'should notify monit to restart if the inventory.monitrc file is touched' do
          resource = chef_run.template('/etc/monit/conf.d/inventory.monitrc')
          expect(resource).to notify('service[monit]').to(:restart).delayed
        end

        it 'should create the nginx.monitrc file' do
          expect(chef_run).to create_template('/etc/monit/conf.d/nginx.monitrc').with(
            owner: 'root',
            group: 'root',
            mode: '600',
            source: 'nginx.monitrc.erb'
          )
        end

        it 'should notify monit to restart if the nginx.monitrc file is touched' do
          resource = chef_run.template('/etc/monit/conf.d/nginx.monitrc')
          expect(resource).to notify('service[monit]').to(:restart).delayed
        end
      end
    end
  end
end

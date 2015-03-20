require 'spec_helper'

describe 'optoro_monit::sentinel' do
  Resources::PLATFORMS.each do |platform, value|
    value['versions'].each do |version|
      context "On #{platform} #{version}" do
        include_context 'optoro_monit'

        context 'default sentinel monit configuration' do
          let(:chef_run) do
            ChefSpec::SoloRunner.new(platform: platform, version: version, log_level: :error) do |node|
              node.set['lsb']['codename'] = value['codename']
            end.converge(described_recipe)
          end

          it 'creates monit configuration for sentinel service' do
            expect(chef_run).to create_template('/etc/monit/conf.d/sentinel.conf').with(
              owner: 'root',
              group: 'root',
              source: 'sentinel.monitrc.erb'
            )
          end

          it 'should notify monit to restart if the sentinel.monitrc file is touched' do
            resource = chef_run.template('/etc/monit/conf.d/sentinel.conf')
            expect(resource).to notify('service[monit]').to(:restart).delayed
          end
        end
      end
    end
  end
end

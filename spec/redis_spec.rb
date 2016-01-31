require 'spec_helper'

describe 'optoro_monit::redis' do
  Resources::PLATFORMS.each do |platform, value|
    value['versions'].each do |version|
      context "On #{platform} #{version}" do
        include_context 'optoro_monit'

        context 'default redis monit configuration' do
          let(:chef_run) do
            ChefSpec::SoloRunner.new(platform: platform, version: version, log_level: :error) do |node|
              node.set['lsb']['codename'] = value['codename']
              node.set['redisio']['servers'] = [{ 'port' => 6379 }, { 'port' => 6380 }]
            end.converge(described_recipe)
          end

          [6379, 6380].each do |port|
            it "creates monit configuration for redis service on port #{port}" do
              expect(chef_run).to create_template("/etc/monit/conf.d/#{port}.conf").with(
                owner: 'root',
                group: 'root',
                source: 'redis.monitrc.erb'
              )
            end

            it "should notify monit to restart if the redis#{port}.monitrc file is touched" do
              resource = chef_run.template("/etc/monit/conf.d/#{port}.conf")
              expect(resource).to notify('service[monit]').to(:restart).delayed
            end
          end
        end
      end
    end
  end
end

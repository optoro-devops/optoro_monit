require 'spec_helper'

describe 'optoro_monit::default' do
  Resources::PLATFORMS.each do |platform, value|
    value['versions'].each do |version|
      context "On #{platform} #{version}" do
        include_context 'optoro_monit'

        let(:chef_run) do
          ChefSpec::SoloRunner.new(platform: platform, version: version, log_level: :error) do |node|
            node.set['lsb']['codename'] = value['codename']
          end.converge(described_recipe)
        end

        before do
          stub_command('which monit').and_return('/usr/bin/monit')
        end

        it 'should install the monit package' do
          expect(chef_run).to install_package('monit')
        end

        it 'should create the monit log directory' do
          expect(chef_run).to create_directory('/var/optoro/log')
        end

        # TODO: figure out how to test command execution and handle ruby only_if conditions
        # it 'shoudl disable the default init script' do
        #   expect(chef_run).to run_bash('disabling init.d script for monit')
        # end

        it 'should start the monit service' do
          expect(chef_run).to start_service('monit')
        end

        it 'should create the monitrc configuration file' do
          expect(chef_run).to create_template('/etc/monit/monitrc').with(
            owner: 'root',
            group: 'root',
            source: 'monitrc.erb'
          )
        end

        it 'should restart monit if the monitrc is changed' do
          resource = chef_run.template('/etc/monit/monitrc')
          expect(resource).to notify('service[monit]').to(:restart).delayed
        end
      end
    end
  end
end

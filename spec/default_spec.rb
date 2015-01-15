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

        it 'should create the upstart file' do
          expect(chef_run).to create_cookbook_file('/etc/init/monit.conf').with(
            user: 'root',
            group: 'root',
            mode: '0644'
          )
        end

        it 'should start the monit service' do
          expect(chef_run).to start_service('monit').with(
            provider: Chef::Provider::Service::Upstart
          )
        end

        it 'should allow monit to startup' do
          expect(chef_run).to create_template('/etc/default/monit').with(
            owner: 'root',
            group: 'root',
            mode: '0644'
          )
        end

        it 'should notify a monit restart when creating the /etc/default/monit file' do
          resource = chef_run.template('/etc/default/monit')
          expect(resource).to notify('execute[restart-monit]').to(:run).immediately
        end

        it 'should create the monitrc configuration file' do
          expect(chef_run).to create_template('/etc/monit/monitrc').with(
            owner: 'root',
            group: 'root',
            source: 'optoro-monitrc.erb'
          )
        end

        it 'should restart monit if the monitrc is changed' do
          resource = chef_run.template('/etc/monit/monitrc')
          expect(resource).to notify('execute[restart-monit]').to(:run).immediately
        end

        it 'should delete the original init script for monit' do
          expect(chef_run).to delete_file('/etc/init.d/monit')
        end
      end
    end
  end
end

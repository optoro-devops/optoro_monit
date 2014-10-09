#
# Cookbook Name:: optoro_monit
# Recipe:: default
#
# Copyright (C) 2014 Optoro Inc
#
# All rights reserved - Do Not Redistribute
#

package 'monit'

directory node['monit']['logdirectory'] do
  action :create
  recursive true
end

template '/etc/monit/monitrc' do
  owner "root"
  group "root"
  mode "0700"
  action :create
  source 'optoro-monitrc.erb'
  notifies :run, "execute[restart-monit]", :immediately
end

# disable traditional init.d way of starting monit
bash "disabling init.d script for monit" do
  user "root"
  code <<-EOC
  update-rc.d -f monit remove
  /etc/init.d/monit stop
  EOC
  only_if { ::File.exist? '/etc/init.d/monit' }
end

# Use upstart to manage monit
cookbook_file '/etc/init/monit.conf' do
  owner "root"
  group "root"
  mode "0644"
  source "monit-upstart"
  #notifies :run, "execute[restart-monit]", :immediately
end

service 'monit' do
  action :start
  provider Chef::Provider::Service::Upstart
end

# allow monit to startup
template '/etc/default/monit' do
  owner "root"
  group "root"
  mode "0644"
  source "allow-monit-start.erb"
  notifies :run, "execute[restart-monit]", :immediately
end

execute "restart-monit" do
  command "initctl reload-configuration"
  command "monit reload"
  action :nothing
end

# we want to replace the init script with an upstart script
file '/etc/init.d/monit' do
  action :delete
end

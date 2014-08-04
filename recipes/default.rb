#
# Cookbook Name:: optoro_monit
# Recipe:: default
#
# Copyright (C) 2014 Optoro Inc
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'monit'

chef_gem 'chef-rewind'
require 'chef/rewind'

directory node['monit']['logdirectory'] do
  action :create
  recursive true
end

# override the default community version of the monitrc.erb file as it is not customizable enough
rewind :template => '/etc/monit/monitrc' do
  source 'optoro-monitrc.erb'
  cookbook_name 'optoro_monit'
end

cookbook_file '/etc/init.d/monit' do
  source 'monit-init'
  action :create
  notifies :restart, 'service[monit]', :delayed
end

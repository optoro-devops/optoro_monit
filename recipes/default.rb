#
# Cookbook Name:: optoro_monit
# Recipe:: default
#
# Copyright (C) 2014 Optoro Inc
#
# All rights reserved - Do Not Redistribute
#

directory node['monit']['logdirectory'] do
  action :create
  recursive true
end

include_recipe 'monit'

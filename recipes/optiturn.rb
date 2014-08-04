
include_recipe 'optoro_monit::default'

template '/etc/monit/conf.d/inventory.monitrc' do
  action :create
  owner 'root'
  group 'root'
  mode '600'
  source 'inventory.monitrc.erb'
  notifies :restart, 'service[monit]', :delayed
end

template '/etc/monit/conf.d/nginx.monitrc' do
  action :create
  owner 'root'
  group 'root'
  mode '600'
  source 'nginx.monitrc.erb'
  notifies :restart, 'service[monit]', :delayed
end

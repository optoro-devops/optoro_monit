include_recipe 'optoro_monit'

template '/etc/monit/conf.d/sentinel.conf' do
  action :create
  owner 'root'
  group 'root'
  mode '600'
  source 'sentinel.monitrc.erb'
  notifies :restart, 'service[monit]', :delayed
end

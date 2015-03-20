include_recipe 'optoro_monit'

node['redisio']['servers'].each do |server|
  template "/etc/monit/conf.d/redis#{server['port']}.conf" do
    action :create
    owner 'root'
    group 'root'
    mode '600'
    source 'redis.monitrc.erb'
    variables(port: server['port'])
    notifies :restart, 'service[monit]', :delayed
  end
end

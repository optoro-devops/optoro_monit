include_recipe 'optoro_monit'

node['redisio']['servers'].each do |server|
  monitrc server['port'] do
    template_cookbook 'optoro_monit'
    template_source 'redis.monitrc.erb'
    variables port: server['port']
  end
end

include_recipe 'optoro_monit'

template "/etc/monit/conf.d/rabbitmq.conf" do
  mode 644
  owner 'root'
  group 'root'
  source 'optoro_rabbitmq_monit.erb'
end


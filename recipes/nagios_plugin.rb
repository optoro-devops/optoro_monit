cookbook_file '/usr/lib/nagios/plugins/check_monit.py' do
  source 'check_monit.py'
  owner 'root'
  group 'root'
  mode 755
end

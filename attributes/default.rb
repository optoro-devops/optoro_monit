# new attributes not part of the community cookbook
node.default['monit']['logdirectory'] = '/var/optoro/log'
node.default['monit']['idfile'] = '/var/.monit.id'
node.default['monit']['statefile'] = '/var/.monit.state'

# override default attributes from the community monit cookbook
node.override['monit']['poll_period'] = '120'
node.override['monit']['poll_start_delay'] = '240'
node.override['monit']['logfile'] = '/var/optoro/log/monit.log'
node.override['monit']['logfile'] = "#{node['monit']['logdirectory']}/monit.log"
node.override['monit']['mailserver']['host'] = 'mail-temp-internal.optoro.com'
node.override['monit']['notify_email'] = 'sysadmin@optoro.com'
node.override['monit']['port'] = '2812'

node.default['monit']['allow'] << 'admin:monit'

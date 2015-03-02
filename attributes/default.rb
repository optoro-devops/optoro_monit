# new attributes not part of the community cookbook
default['monit']['logdirectory'] = '/var/optoro/log'
default['monit']['idfile'] = '/var/.monit.id'
default['monit']['statefile'] = '/var/.monit.state'

# override default attributes from the community monit cookbook
default['monit']['poll_period'] = '120'
default['monit']['poll_start_delay'] = 0
default['monit']['logfile'] = '/var/optoro/log/monit.log'
default['monit']['logfile'] = "#{node['monit']['logdirectory']}/monit.log"
default['monit']['mailserver']['host'] = 'mail-temp-internal.optoro.com'
default['monit']['notify_email'] = 'sysadmin@optoro.com'
default['monit']['port'] = '2812'

default['monit']['allow'] = ['admin:monit', '@root', 'localhost']
default['monit']['address'] = 'localhost'

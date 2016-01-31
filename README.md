# Description

Installs/Configures optoro_monit

# Requirements

## Platform:

* Ubuntu (= 14.04)

## Cookbooks:

* monit

# Attributes

* `node['monit']['logdirectory']` -  Defaults to `/var/optoro/log`.
* `node['monit']['idfile']` -  Defaults to `/var/.monit.id`.
* `node['monit']['statefile']` -  Defaults to `/var/.monit.state`.
* `node['monit']['poll_period']` -  Defaults to `120`.
* `node['monit']['poll_start_delay']` -  Defaults to `0`.
* `node['monit']['logfile']` -  Defaults to `#{node['monit']['logdirectory']}/monit.log`.
* `node['monit']['mailserver']['host']` -  Defaults to `mail-temp-internal.optoro.com`.
* `node['monit']['notify_email']` -  Defaults to `sysadmin@optoro.com`.
* `node['monit']['port']` -  Defaults to `2812`.
* `node['monit']['allow']` -  Defaults to `[ ... ]`.
* `node['monit']['address']` -  Defaults to `localhost`.

# Recipes

* optoro_monit::default
* optoro_monit::rabbitmq
* optoro_monit::redis
* optoro_monit::sentinel

# License and Maintainer

Maintainer:: Optoro (<devops@optoro.com>)

License:: MIT

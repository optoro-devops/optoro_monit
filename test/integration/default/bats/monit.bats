#!/usr/bin/env bash

@test "it installs monit" {
  run which monit
  [ $status = 0 ]
}

@test "it creates the monitrc file" {
  [ -f "/etc/monit/monitrc" ]
}

@test "it creates the upstart script" {
  [ -f "/etc/init/monit.conf" ]
}

@test "it removes the original init script" {
  [ ! -f "/etc/init.d/monit" ]
}

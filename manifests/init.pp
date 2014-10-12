# == Class: transmission
#
# This class is the entry point for the transmission insallation
# and management module. It calls and anchors each of the worker classes
# to configure, install, and run transmission.
#
# === Parameters
#
# [*url*]
# [*user*]
# [*group*]
# [*port*]
# [*rpc_whitelist*]
# [*config_dir*]
# [*settings*]
#
# === Variables
#
# None
#
# === Examples
#
#  include transmission
#
# === Authors
#
# Tom Robinson <robinson.tj@gmail.com>
#
# === Copyright
#
# Copyright 2014 Tom Robinson
#
class transmission (
  $url           = 'ppa:transmissionbt/ppa',
  $user          = 'debian-transmission',
  $group         = 'debian-transmission',
  $port          = '9091',
  $rpc_whitelist = '127.0.0.1,10.0.*.*,192.168.*.*',
  $config_dir    = '/etc/transmission-daemon',
  $settings      = {
  }
  ,) {
  include apt
  include transmission::install_deps
  include transmission::install
  include transmission::config
  include transmission::service
  include transmission::exports
  
  Class['transmission::install_deps'] ->
  Class['transmission::install'] ->
  Class['transmission::config'] ~>
  Class['transmission::service']
  }
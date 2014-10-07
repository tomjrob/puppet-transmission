# == Class: transmission::config
#
# This class holds default configuration for required parameters
# for transmission::init. It is a legacy pattern if you do not use data in
# modules or site data through heira.
#
# === Parameters
#
# None
#
# === Variables
#
# [*transmission::config_dir*]
# [*transmission::user*]
# [*transmission::group*]
#
# === Examples
#
#  Not meant to be publicly consumed.
#
# === Authors
#
# Tom Robinson <robinson.tj@gmail.com>
#
# === Copyright
#
# Copyright 2014 Tom Robinson
#
class transmission::config inherits transmission {
  file { "${transmission::config_dir}/settings.json":
    content => template('transmission/settings.json.erb'),
    owner   => $transmission::user,
    group   => $transmission::group,
    notify  => Exec['tr_stop'],
    mode    => '0600';
  }

  exec { 'tr_stop':
    # Config has already been updated. Copy config to preserve,
    # stop service (config is overwritten with running variables),
    # copy preserved config back to real config file
    command     => 'cp -a settings.json settings.json.tmp && service \
transmission-daemon stop && cp -a settings.json.tmp settings.json',
    cwd         => $transmission::config_dir,
    path        => '/usr/sbin:/usr/bin:/sbin:/bin',
    refreshonly => true,
  }
}
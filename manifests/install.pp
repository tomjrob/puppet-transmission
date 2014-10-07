# == Class: transmission::install
#
# This is the install class for the transmission module.
#
# === Parameters
#
# None
#
# === Variables
#
# [*transmission::user*]
#
# === Examples
#
#  include transmission::install
#
# === Authors
#
# Tom Robinson <robinson.tj@gmail.com>
#
# === Copyright
#
# Copyright 2014 Tom Robinson
#
class transmission::install inherits transmission {
  # Create User
  user { $transmission::user:
    ensure    => 'present',
    allowdupe => false,
    shell     => '/bin/bash',
    system    => true;
  }

  # Get latest transmission from ppa source
  ensure_resource('package', transmission-daemon, {
    ensure => 'installed'
  }
  )

}
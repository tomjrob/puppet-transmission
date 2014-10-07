# == Class: transmission::service
#
# This class manages the transmission service.
#
# === Parameters
#
# None
#
# === Variables
#
# None
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
class transmission::service inherits transmission {
  service { 'transmission-daemon':
    ensure     => running,
    name       => 'transmission-daemon',
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }
}
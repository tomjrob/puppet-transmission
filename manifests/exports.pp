# == Class: transmission::exports
#
# This class exports connection information for transmission so that other
# services can connect automatically. 
#
# === Parameters
#
# None
#
# === Variables
#
# [*---*]
#
# === Examples
#
#  ---
#
# === Authors
#
# Tom Robinson <robinson.tj@gmail.com>
#
# === Copyright
#
# Copyright 2014 Tom Robinson
#
class transmission::exports inherits transmission {
  @@transmission_host { "check_zfs${hostname}":
      use                 => 'generic-service',
      host_name           => "$fqdn",
      check_command       => 'check_nrpe_1arg!check_zfs',
      service_description => "check_zfs${hostname}",
      target              => '/etc/nagios3/conf.d/nagios_service.cfg',
      notify              => Service[$nagios::params::nagios_service],
    }
}
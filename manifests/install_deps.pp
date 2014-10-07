# == Class: transmission::install_deps
#
# This class installs/executes any dependencies for the transmission
# install.
#
# === Parameters
#
# None
#
# === Variables
#
# [*transmission::url*]
#   The ppa url as set by the init.pp class for downloading transmission.
#   This url must be set in config.pp or from hiera data (either data
#   in modules or site data).
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
class transmission::install_deps inherits transmission {
  apt::ppa { '$transmission::url': } ->
  exec { 'trans_apt_update':
    command => '/usr/bin/apt-get -y update',
    path    => '/usr/bin/',
    onlyif  => "test \\( ! -f /var/cache/apt/pkgcache.bin \\) \
    -o \\( ! -z `/usr/bin/find /etc/apt/* \
      -cnewer /var/cache/apt/pkgcache.bin \
      -print \
      -quit` 1> /dev/null 2>/dev/null \\)",
  }
}
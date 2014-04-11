class transmission::service inherits transmission {
  service { 'transmission-daemon':
    name => 'transmission-daemon',
    ensure => running,
    enable => true,
    hasrestart => true,
    hasstatus => true,
  }
}
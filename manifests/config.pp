class transmission::config inherits transmission {
  file { "${config_dir}/settings.json":
    content => template('transmission/settings.json.erb'),
    owner  => "${user}",
    group  => "${group}",
    notify => Exec['tr_stop'],
    mode    => '0600';
  }  
  
  exec { "tr_stop":
    #Config has already been updated. Copy config to preserve, stop service (config is overwritten with running variables), copy preserved config back to real config file
    command => 'cp -a settings.json settings.json.tmp && service transmission-daemon stop && cp -a settings.json.tmp settings.json',
    cwd => "${config_dir}",
    path => "/usr/sbin:/usr/bin:/sbin:/bin",
    refreshonly => true,
    }
}
class transmission (
  $url,
  $user,
  $group,
  $port,
  $rpc_whitelist,
  $config_dir,
  $settings={},
) {
  
  validate_absolute_path($config_dir)
  validate_string($url)
  validate_string($user)
  validate_string($group)
  
  include apt
  
  anchor { 'transmission::begin': } ->
  class { '::transmission::install_deps': } ->
  class { '::transmission::install': } ->
  class { '::transmission::config': } ~> 
  class { '::transmission::service': } ->
  anchor { 'transmission::end': }
  }
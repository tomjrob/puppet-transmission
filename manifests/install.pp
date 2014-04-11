class transmission::install inherits transmission {
  # Create User
  user { "${user}":
    ensure    => 'present',
    allowdupe => false,
    shell     => '/bin/bash',
    system    => true;
    }
   
  # Get latest transmission from ppa source
  ensure_resource("package", transmission-daemon, {
    "ensure" => "installed"
    })
  
}
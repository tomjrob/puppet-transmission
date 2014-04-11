class transmission::install_deps inherits transmission {
  apt::ppa { "${url}": }
  ->  
  exec { "trans_apt_update":
    command => '/usr/bin/apt-get -y update',
    path => "/usr/bin/",
    onlyif => "test \\( ! -f /var/cache/apt/pkgcache.bin \\) -o \\( ! -z `/usr/bin/find /etc/apt/* -cnewer /var/cache/apt/pkgcache.bin -print -quit` 1> /dev/null 2>/dev/null \\)",
    }
}
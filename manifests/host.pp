# /etc/puppetlabs/puppet/modules/apache/manifests/vhost.pp
define transmission::host ($host, $port) {
  include transmission
}
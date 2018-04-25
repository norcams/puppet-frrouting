#frrouting::zebra
class frrouting::zebra (
  $zebra_password        = $frrouting::params::zebra_password,
  $zebra_enable_password = $frrouting::params::zebra_enable_password,
  $zebra_log_file        = $frrouting::params::zebra_log_file,
  $zebra_ip6_routes      = $frrouting::params::zebra_ip6_routes,
  $zebra_ip_routes       = $frrouting::params::zebra_ip_routes,
  $zebra_interfaces      = $frrouting::params::zebra_interfaces,
  $zebra_generic_options = $frrouting::params::zebra_generic_options,
) {

  unless $single_config_file == true {
    file { '/etc/frr/zebra.conf':
      mode    => '0644',
      owner   => 'frr',
      group   => 'frr',
      content => template('frrouting/zebra.conf.erb'),
      notify  => Service['frr'],
    }
  }
}

#Class frrouting::bgpd

class frrouting::bgpd (
  $bgp_hostname        = $frrouting::params::bgp_hostname,
  $bgp_password        = $frrouting::params::bgp_password,
  $bgp_logfile         = $frrouting::params::bgp_logfile,
  $bgp_as              = $frrouting::params::bgp_as,
  $bgp_options         = $frrouting::params::bgp_options,
  $bgp_networks        = $frrouting::params::bgp_networks,
  $bgp_networks6       = $frrouting::params::bgp_networks6,
  $bgp_neighbors       = $frrouting::params::bgp_neighbors,
  $bgp_neighbors6      = $frrouting::params::bgp_neighbors6,
  $bgp_neighbor_groups = $frrouting::params::bgp_neighbor_groups,
  $bgp_accesslist      = $frrouting::params::bgp_accesslist,
  $bgp_ip_prefix_list  = $frrouting::params::bgp_ip_prefix_list,
  $bgp_route_maps      = $frrouting::params::bgp_route_maps,
  $bgp_generic_options = $frrouting::params::bgp_generic_options,
) {

  unless $frrouting::single_config_file == true {
    file { '/etc/frr/bgpd.conf':
      mode    => '0644',
      owner   => 'frr',
      group   => 'frr',
      content => template('frrouting/bgpd.conf.erb'),
      notify  => Service['frr'],
    }
  }
}

#Class frrouting::frrouting
#
# For single config file deployments
#
# Supports zebra/bgpd for now

class frrouting::frrouting (
  $bgp_hostname          = $frrouting::params::bgp_hostname,
  $bgp_password          = $frrouting::params::bgp_password,
  $bgp_logfile           = $frrouting::params::bgp_logfile,
  $bgp_as                = $frrouting::params::bgp_as,
  $bgp_options           = $frrouting::params::bgp_options,
  $bgp_networks          = $frrouting::params::bgp_networks,
  $bgp_networks6         = $frrouting::params::bgp_networks6,
  $bgp_neighbors         = $frrouting::params::bgp_neighbors,
  $bgp_neighbors6        = $frrouting::params::bgp_neighbors6,
  $bgp_neighbor_groups   = $frrouting::params::bgp_neighbor_groups,
  $bgp_accesslist        = $frrouting::params::bgp_accesslist,
  $bgp_ip_prefix_list    = $frrouting::params::bgp_ip_prefix_list,
  $bgp_route_maps        = $frrouting::params::bgp_route_maps,
  $bgp_generic_options   = $frrouting::params::bgp_generic_options,
  $zebra_password        = $frrouting::params::zebra_password,
  $zebra_enable_password = $frrouting::params::zebra_enable_password,
  $zebra_log_file        = $frrouting::params::zebra_log_file,
  $zebra_ip6_routes      = $frrouting::params::zebra_ip6_routes,
  $zebra_ip_routes       = $frrouting::params::zebra_ip_routes,
  $zebra_interfaces      = $frrouting::params::zebra_interfaces,
  $zebra_generic_options = $frrouting::params::zebra_generic_options,
) {

  file { '/etc/frr/frr.conf':
    mode    => '0644',
    owner   => 'frr',
    group   => 'frr',
    content => template('frrouting/frr.conf.erb'),
    notify  => Service['frr'],
  }
}

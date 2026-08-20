#Class frrouting::frrouting
#
# For single config file deployments
#
# Supports zebra/bgpd for now

class frrouting::frrouting (
  $config_dir            = $frrouting::config_dir,
  $config_owner          = $frrouting::config_owner,
  $config_grp            = $frrouting::config_grp,
  $manage_service        = $frrouting::manage_service,
  $sonic_container       = $frrouting::sonic_container,
  $frr_defaults          = undef,
  $frr_template          = 'frrouting/frr.conf.erb',
  $bgp_hostname          = $frrouting::params::bgp_hostname,
  $bgp_in_default_vrf    = true,
  $bgp_password          = $frrouting::params::bgp_password,
  $bgp_logfile           = $frrouting::params::bgp_logfile,
  $bgp_as                = $frrouting::params::bgp_as,
  $bgp_options           = $frrouting::params::bgp_options,
  $bgp_options4          = $frrouting::params::bgp_options4,
  $bgp_options6          = $frrouting::params::bgp_options6,
  $bgp_networks          = $frrouting::params::bgp_networks,
  $bgp_networks6         = $frrouting::params::bgp_networks6,
  $bgp_neighbors         = $frrouting::params::bgp_neighbors,
  $bgp_neighbors6        = $frrouting::params::bgp_neighbors6,
  $bgp_neighbor_groups   = $frrouting::params::bgp_neighbor_groups,
  $bgp_accesslist        = $frrouting::params::bgp_accesslist,
  $bgp_accesslist6       = $frrouting::params::bgp_accesslist6,
  $bgp_ip_prefix_list    = $frrouting::params::bgp_ip_prefix_list,
  $bgp_ipv6_prefix_list  = $frrouting::params::bgp_ipv6_prefix_list,
  $bgp_route_maps        = $frrouting::params::bgp_route_maps,
  $bgp_generic_options   = $frrouting::params::bgp_generic_options,
  $bgp_vrf_options       = $frrouting::params::bgp_vrf_options,
  $zebra_password        = $frrouting::params::zebra_password,
  $zebra_enable_password = $frrouting::params::zebra_enable_password,
  $zebra_log_file        = $frrouting::params::zebra_log_file,
  $zebra_ip6_routes      = $frrouting::params::zebra_ip6_routes,
  $zebra_ip_routes       = $frrouting::params::zebra_ip_routes,
  $zebra_interfaces      = $frrouting::params::zebra_interfaces,
  $zebra_generic_options = $frrouting::params::zebra_generic_options,
  $vrf_params            = $frrouting::params::vrf_params,
) {

  if $bgp_in_default_vrf == true and $bgp_vrf_options.has_key('default') {
    fail('If you define routing in default VRF in bgp_vrf_options, you must set bgp_in_default_vrf to false. Will not configure FRR due to invalid configuration')
  }

  if $sonic_container {
    file { "${config_dir}/frr.conf":
      mode    => '0644',
      owner   => $config_owner,
      group   => $config_grp,
      content => template('frrouting/frr.conf.erb'),
      notify    => $manage_service ? {
        true    => [Exec['sonic_container_frrconf_reload']],
        default => undef,
      },
    }
  } else {
    file { "${config_dir}/frr.conf":
      mode      => '0644',
      owner     => $config_owner,
      group     => $config_grp,
      content   => template($frr_template),
      notify    => $manage_service ? {
        true    => Service['frr'],
        default => undef,
      },
    }
  }

  exec { 'sonic_container_frrconf_reload':
    command     => '/usr/bin/docker exec bgp sh -c "/usr/bin/python /usr/lib/frr/frr-reload.py --reload /etc/frr/frr.conf"',
    refreshonly => true,
  }
}

# Variables
# NOTE: uncertain whether or not to have configuration file or everything parameters
class frrouting::params {

  $manage_package = true
  $manage_service = true
  # Cumulus Linux defaults to use a single config file, frrouting.conf
  $single_config_file = false
  $sonic_container = false
  $config_dir   = '/etc/frr'
  $config_owner = 'frr'
  $config_grp   = 'frr'
  # running zebra is highly recommended
  $zebra   = true
  $bgpd    = false
  $ospfd   = false
  $ospf6d  = false
  $ripd    = false
  $ripngd  = false
  $isisd   = false
  $babeld  = false # single file ffr.conf only
  $fabricd = false # single file ffr.conf only
  $pimd    = false # single file ffr.conf only
  $ldpd    = false # single file ffr.conf only
  $nhrpd   = false # single file ffr.conf only
  $eigrpd  = false # single file ffr.conf only
  $sharpd  = false # single file ffr.conf only
  $pbrd    = false # single file ffr.conf only

  #do not publish password in public repositories
  $password = 'pass123'
  $router_id = $::network_lo

  #zebra variables
  $zebra_password = 'cn321'
  $zebra_enable_password = 'cn321'
  $zebra_log_file = '/var/log/frrouting/zebra.log'
  #$zebra_ip-routes is an array of routes, ie
  # frrouting::zebra:bgp_ip-route => [ '0.0.0.0/0 192.168.0.1', '10.0.0.0/24 10.0.0.1', ],
  $zebra_ip_routes = undef
  $zebra_ip6_routes = undef
  #$zebra_interfaces is a hash of arrays with interface parameters
  $zebra_interfaces = undef
  #$zebra_generic_options is an array of generic options for bgpd, ie
  # frrouting::zebra::zebra_generic_options => { 'ip' => 'forwarding', 'ipv6' => 'forwarding' }
  $zebra_generic_options = undef

  # vrf params is an array of generic options for vrf configuration
  $vrf_params = undef

  #BGP variables
  $bgp_hostname = 'bgpd'
  $bgp_password = 'cn321'
  $bgp_as = '65001'
  $bgp_logfile = '/var/log/frrouting/bgpd.log'
  #$bgp_networks and bgp_networks6 are arrays of bgp networks, ie
  # frrouting::bgpd::bgp_networks => [ '0.0.0.0/0', '192.168.0.0/24', ],
  $bgp_networks = undef
  $bgp_networks6 = undef
  #$bgp_options is an array of bgp options, ie
  # frrouting::bgpd::bgp_options => [ 'log-neighbor-changes', 'router-id 192.168.0.1', ],
  $bgp_options = undef
  $bgp_options4 = undef
  $bgp_options6 = undef
  #$bgp_neighbor_group is a hash of arrays with group names and options, ie
  # frrouting::bgpd::bgp_neighbor_groups => { 'name-of-group': options => [ 'peer-group', 'remote-as 65535', ], members => [ '192.168.0.10', '192.168.0.11', ], }
  # You can add members and/or members6 (also specify networks6) and options6
  $bgp_neighbor_groups = undef
  #$bgp_neighbors is an array of of neighbor comands
  $bgp_neighbors = undef
  $bgp_neighbors6 = undef
  #$bgp_accesslists is a hash of arrays with list names and rules, ie
  # frrouting::bgpd::bgp_accesslists => { '10' => [ 'permit 10.0.0.0 0.0.0.255', 'permit 192.168.0.0 0.0.255.255', ], }
  $bgp_accesslist = undef
  $bgp_accesslist6 = undef
  #$bgp_ip_prefix is an array of ip prefixes, ie
  # frrouting::bgpd::bgp_ip_prefix_list => [ 'routes-from-external seq 5 deny any', 'routes-to-external seq 5 permit 0.0.0.0/0', ],
  $bgp_ip_prefix_list = undef
  $bgp_ipv6_prefix_list = undef
  #$bgp_route_maps is a hash of arrays with route-maps with options, ie
  # frrouting::bgpd::bgp_route_maps => { 'ADVERTS permit 5' => [ 'match ip address prefix-list routes-from-external ', ' set as-path prepend 123 123', ], }
  $bgp_route_maps = undef
  #$bgp_generic_options is an array of generic options for bgpd
  $bgp_generic_options = undef
  #$bgp_vrf_options is a hash containg settings for each vrf with 'address_family4_unicast', 'address_family6_unicast', address_family_l2vpn', and 'options'
  $bgp_vrf_options = undef

  #OSPF variables
  $ospf_logfile = '/var/log/frr/ospfd.log'
  #$ospf_interfaces is an array in the format 
  $ospf_interfaces = {
    interface1 => { 'interface' => '192.0.2.1/24', 'area' => '0'},
  }

  #ospf6_interfaces is an array. By default assign it the same values as ospf_interfaces
  $ospf6_interfaces = $ospf_interfaces
}

#=== Class: frrouting
# Description TBD
# Parameters - tbd
#
# === Examples
# TBD (see a pattern?)
#
# === Authors
# Leslie Carr <leslie@cumulusnetworks.com>
#
# === License
# Apache v2
class frrouting (
  $manage_package     = $frrouting::params::manage_package,
  $manage_service     = $frrouting::params::manage_service,
  $single_config_file = $frrouting::params::single_config_file,
  $sonic_container    = $frrouting::params::sonic_container,
  $config_dir         = $frrouting::params::config_dir,
  $config_owner       = $frrouting::params::config_owner,
  $config_grp         = $frrouting::params::config_grp,
  $zebra              = $frrouting::params::zebra,
  $bgpd               = $frrouting::params::bgpd,
  $ospfd              = $frrouting::params::ospfd,
  $ospf6d             = $frrouting::params::ospf6d,
  $ripd               = $frrouting::params::ripd,
  $ripngd             = $frrouting::params::ripngd,
  $isisd              = $frrouting::params::isisd,
  $babeld             = $frrouting::params::babeld,
  $fabricd            = $frrouting::params::fabricd,
  $pimd               = $frrouting::params::pimd,
  $ldpd               = $frrouting::params::ldpd,
  $nhrpd              = $frrouting::params::nhrpd,
  $eigrpd             = $frrouting::params::eigrpd,
  $sharpd             = $frrouting::params::sharpd,
  $pbrd               = $frrouting::params::pbrd,

) inherits frrouting::params {
  if $manage_package {
    package { 'frr':
      ensure   => present,
      before   => Service['frr']
    }
  }

  if $manage_service and ! $sonic_container {
    service { 'frr':
      ensure      => running,
      hasrestart  => true,
      hasstatus   => true,
      enable      => true,
    }

    file { "${config_dir}/daemons":
      mode    => '0644',
      owner   => $config_owner,
      group   => $config_grp,
      content => template('frrouting/daemons.erb'),
      notify  => Service['frr'],
    }

    file { "${config_dir}/vtysh.conf":
      mode    => '0644',
      owner   => $config_owner,
      group   => $config_grp,
      content => template('frrouting/vtysh.conf.erb'),
      notify  => Service['frr'],
    }
  }

  if $manage_service and $sonic_container {
    file { "${config_dir}/daemons":
      mode    => '0644',
      owner   => $config_owner,
      group   => $config_grp,
      content => template('frrouting/daemons.erb'),
      notify  => [Exec['sonic_container_frr_reload']],
    }

    exec { 'sonic_container_frr_reload':
      command     => '/usr/bin/docker exec bgp sh -c "/usr/bin/python /usr/lib/frr/frr-reload.py --reload /etc/frr/frr.conf"',
      refreshonly => true,
    }
  }

  if $single_config_file == false {
    if $zebra == true {
      include frrouting::zebra
    }

    if $bgpd == true {
      include frrouting::bgpd
    }

    if $ospfd == true {
      include frrouting::ospfd
    }

    if $ospf6d == true {
      include frrouting::ospf6d
    }

    if $ripd == true {
      include frrouting::ripd
    }

    if $ripngd == true {
      include frrouting::ripngd
    }

    if $isisd == true {
      include frrouting::isisd
    }

    if $babeld == true {
      include frrouting::babeld
    }
  }

  if $single_config_file == true {
    include frrouting::frrouting
  }
}

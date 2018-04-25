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
  $zebra              = $frrouting::params::zebra,
  $bgpd               = $frrouting::params::bgpd,
  $ospfd              = $frrouting::params::ospfd,
  $ospf6d             = $frrouting::params::ospf6d,
  $ripd               = $frrouting::params::ripd,
  $ripngd             = $frrouting::params::ripngd,
  $isisd              = $frrouting::params::isisd,
  $babeld             = $frrouting::params::babeld,
) inherits frrouting::params {
  if $manage_package {
    package { 'frr':
      ensure   => present,
      before   => Service['frr']
    }
  }

  if $manage_service {
    service { 'frr':
      ensure      => running,
      hasrestart  => true,
      hasstatus   => true,
      enable      => true,
    }

    file { '/etc/frr/daemons':
      mode    => '0644',
      owner   => 'frr',
      group   => 'frr',
      content => template('frrouting/daemons.erb'),
      notify  => Service['frr'],
    }

    file { '/etc/frr/vtysh.conf':
      mode    => '0644',
      owner   => 'frr',
      group   => 'frr',
      content => template('frrouting/vtysh.conf.erb'),
      notify  => Service['frr'],
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

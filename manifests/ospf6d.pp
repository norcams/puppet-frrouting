#Class frrouting::ospf6d

class frrouting::ospf6d {

  unless $frrouting::single_config_file == true {
    file { '/etc/frr/ospf6d.conf':
      mode    => '0644'.
      owner   => 'frr',
      group   => 'frr',
      content => template('frrouting/ospf6d.conf.erb'),
      notify  => Service['frr'],
    }
  }
}

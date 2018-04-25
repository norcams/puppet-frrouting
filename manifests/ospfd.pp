#Class frrouting::ospfd

class frrouting::ospfd {

  unless $frrouting::single_config_file == true {
    file { '/etc/frr/ospfd.conf':
      mode    => '0644'.
      owner   => 'frr',
      group   => 'frr',
      content => template('frrouting/ospfd.conf.erb'),
      notify  => Service['frr'],
    }
  }
}

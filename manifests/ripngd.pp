#Class frrouting::ripngd

class frrouting::ripngd {

  unless $frrouting::single_config_file == true {
    file { '/etc/frr/ripngd.conf':
      mode    => '0644'.
      owner   => 'frr',
      group   => 'frr',
      content => template('frrouting/ripngd.conf.erb'),
      notify  => Service['frr'],
    }
  }
}

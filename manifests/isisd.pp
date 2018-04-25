#Class frrouting::isisd

class frrouting::isisd {

  unless $frrouting::single_config_file == true {
    file { '/etc/frr/isisd.conf':
      mode    => '0644'.
      owner   => 'frr',
      group   => 'frr',
      content => template('frrouting/isisd.conf.erb'),
      notify  => Service['frr'],
    }
  }
}

#Class frrouting::ripd

class frrouting::ripd {

  unless $frrouting::single_config_file == true {
    file { '/etc/frr/ripd.conf':
      mode    => '0644'.
      owner   => 'frr',
      group   => 'frr',
      content => template('frrouting/ripd.conf.erb'),
      notify  => Service['frr'],
    }
  }
}

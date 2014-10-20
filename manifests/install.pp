class openup::install {
  exec { 'install-openup':
    command => '/usr/bin/ftp -o /usr/local/sbin/openup https://stable.mtier.org/openup',
    creates => '/usr/local/sbin/openup',
  }

  file { '/usr/local/sbin/openup':
    mode    => '0755',
    ensure  => present,
    require => Exec['install-openup'],
  }
}
